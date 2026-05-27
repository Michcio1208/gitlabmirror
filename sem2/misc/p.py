import matplotlib.pyplot as plt
import networkx as nx

# Inicjalizacja grafu skierowanego
G = nx.DiGraph()

# Definicja stanów (Węzły)
states = {
    'S0': 'S0: IDLE\n(Czekaj na START)',
    'S1': 'S1: LOAD\n(Wczytaj A i B,\nwyzeruj P)',
    'S2': 'S2: TEST\n(Sprawdź B=0)',
    'S3': 'S3: ADD\n(Dodaj A do P,\nzmniejsz B)',
    'S4': 'S4: DONE\n(Wynik gotowy)'
}

for node, label in states.items():
    G.add_node(node, label=label)

# Definicja przejść (Krawędzie) i warunków
edges = [
    ('S0', 'S0', 'Start = 0'),
    ('S0', 'S1', 'Start = 1'),
    ('S1', 'S2', 'bezwarunkowo'),
    ('S2', 'S4', 'Z = 1 (B osiągnęło 0)'),
    ('S2', 'S3', 'Z = 0 (B większe od 0)'),
    ('S3', 'S2', 'bezwarunkowo'),
    ('S4', 'S0', 'bezwarunkowo')
]

for edge in edges:
    G.add_edge(edge[0], edge[1], condition=edge[2])

# Parametry wizualizacji
pos = {
    'S0': (0, 1),
    'S1': (1, 1),
    'S2': (1, 0),
    'S3': (0, 0),
    'S4': (2, 0.5)
}

plt.figure(figsize=(10, 6))
labels = nx.get_node_attributes(G, 'label')
edge_labels = nx.get_edge_attributes(G, 'condition')

# Rysowanie węzłów i krawędzi
nx.draw_networkx_nodes(G, pos, node_size=3500, node_color='lightblue', edgecolors='black')
nx.draw_networkx_labels(G, pos, labels, font_size=9, font_weight='bold')
nx.draw_networkx_edges(G, pos, edge_color='gray', arrows=True, arrowstyle='-|>', arrowsize=20, connectionstyle='arc3,rad=0.1')
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels, font_color='red', font_size=8, label_pos=0.3)

# Opis wyjść aktywowanych w poszczególnych stanach (Legenda)
legend_text = (
    "Sygnały wyjściowe automatu:\n"
    "S0: -\n"
    "S1: Load_A=1, Load_B=1, Clr_P=1\n"
    "S2: -\n"
    "S3: Load_P=1, Dec_B=1\n"
    "S4: Ready=1"
)
plt.text(1.8, 1.0, legend_text, fontsize=10, bbox=dict(facecolor='white', edgecolor='black', boxstyle='round,pad=0.5'))

plt.title('Graf stanów automatu sterującego dla układu mnożącego (Metoda FSMD)', fontsize=14, fontweight='bold')
plt.axis('off')
plt.tight_layout()
plt.show()