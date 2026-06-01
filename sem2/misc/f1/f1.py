import streamlit as st
import fastf1
import fastf1.plotting
import matplotlib.pyplot as plt
import pandas as pd

# Konfiguracja strony i cache'owania
st.set_page_config(page_title="F1 Telemetry Hub", layout="wide")
fastf1.plotting.setup_mpl(misc_mpl_mods=False)
fastf1.Cache.enable_cache('f1_cache') # Tworzy folder na pobrane dane

st.title("🏎️ F1 Telemetry & Race Control Hub")

# Pasek boczny do konfiguracji sesji
st.sidebar.header("Wybór sesji")
year = st.sidebar.number_input("Rok", min_value=2018, max_value=2024, value=2023)
gp = st.sidebar.text_input("Grand Prix", value="Monza")
session_type = st.sidebar.selectbox("Sesja", ["FP1", "FP2", "FP3", "Q", "R"], index=4)

@st.cache_data
def load_data(year, gp, session_type):
    session = fastf1.get_session(year, gp, session_type)
    session.load(telemetry=True, weather=False)
    return session

if st.sidebar.button("Załaduj dane"):
    with st.spinner('Pobieranie danych telemetrycznych (to może chwilę potrwać)...'):
        st.session_state.session = load_data(year, gp, session_type)
        st.success("Dane załadowane!")

if 'session' in st.session_state:
    session = st.session_state.session
    
    col1, col2 = st.columns([2, 1])
    
    with col1:
        st.subheader("🗺️ Mapa toru i pozycje (przykładowe okrążenie)")
        # Wybieramy najszybsze okrążenie wyścigu, żeby narysować bazową linię toru
        fastest_lap = session.laps.pick_fastest()
        pos_data = fastest_lap.get_pos_data()
        
        fig, ax = plt.subplots(figsize=(10, 6))
        # Rysowanie kształtu toru
        ax.plot(pos_data['X'], pos_data['Y'], color='white', linestyle='-', linewidth=2, zorder=1)
        
        # Wybór okrążenia do wyświetlenia pozycji aut
        lap_number = st.slider("Wybierz okrążenie", 1, int(session.total_laps), 1)
        laps_selected = session.laps[session.laps['LapNumber'] == lap_number]
        
        # Naniesienie kierowców na mapę w momencie rozpoczęcia wybranego okrążenia
        for index, row in laps_selected.iterrows():
            driver = row['Driver']
            try:
                # Pobranie telemetrii dla danego kierowcy na tym okrążeniu
                driver_tel = row.get_telemetry()
                if not driver_tel.empty:
                    # Bierzemy pierwszą pozycję (początek okrążenia)
                    x = driver_tel['X'].iloc[0]
                    y = driver_tel['Y'].iloc[0]
                    color = fastf1.plotting.driver_color(driver)
                    ax.scatter(x, y, color=color, s=100, zorder=2, label=driver)
                    ax.text(x + 150, y + 150, driver, color='white', fontsize=9)
            except Exception as e:
                pass # Ignoruj brakujące dane dla pojedynczych kierowców

        ax.set_facecolor('black')
        fig.patch.set_facecolor('black')
        ax.set_title(f"{gp} {year} - Pozycje na początku {lap_number} okrążenia", color='white')
        ax.axis('off')
        # Legenda wyłączona, by nie zaśmiecać widoku, inicjały są na mapie
        st.pyplot(fig)

        # Dodatkowa funkcja: Wykres prędkości (Telemetria)
        st.subheader("📈 Analiza prędkości (Najszybsze okrążenie)")
        driver_sel = st.selectbox("Wybierz kierowcę do analizy", session.drivers)
        try:
            d_lap = session.laps.pick_driver(driver_sel).pick_fastest()
            d_tel = d_lap.get_telemetry()
            
            fig_tel, ax_tel = plt.subplots(figsize=(10, 3))
            ax_tel.plot(d_tel['Distance'], d_tel['Speed'], color=fastf1.plotting.driver_color(driver_sel), label=driver_sel)
            ax_tel.set_xlabel("Dystans [m]", color='white')
            ax_tel.set_ylabel("Prędkość [km/h]", color='white')
            ax_tel.tick_params(colors='white')
            ax_tel.set_facecolor('#1e1e1e')
            fig_tel.patch.set_facecolor('#1e1e1e')
            ax_tel.legend()
            st.pyplot(fig_tel)
        except:
            st.warning("Brak danych telemetrycznych dla tego kierowcy.")

    with col2:
        st.subheader("⚠️ Komunikaty Dyrekcji Wyścigu (Race Control)")
        # Pobieranie wiadomości o żółtych flagach, VSC, SC itp.
        rc_messages = session.race_control_messages
        if not rc_messages.empty:
            # Formatowanie danych do czytelnej tabeli
            display_msg = rc_messages[['Time', 'Category', 'Message']]
            st.dataframe(display_msg, use_container_width=True, hide_index=True)
        else:
            st.info("Brak komunikatów dyrekcji wyścigu w tej sesji.")