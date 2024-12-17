# 🍎 FruitSearch - Fruchterkennung mit Machine Learning

## Einleitung
Diese App wurde während eines Mini-Hackathons programmiert, in dem man 3 Aufgaben hatte. Diese war die zweite Aufgabe. Man hatte für jede Aufgabe 1 1/2 Tage Zeit.

### Aufgabe
- Verwende die OpenFoodFacts API.

## Dev Story
Ich wollte mich schon immer mal mit Core ML & Create ML auseinandersetzen und dachte, das wäre die perfekte Möglichkeit, es produktiv und konzentiert auszuprobieren.

Die Idee war, eine App zu programmieren, die mithilfe von Machine Learning Essen erkennen kann. Anschließend soll sie von einer API entsprechende Daten über dieses Essen laden und anzeigen.
Entsprechend dem Zeitlimit habe ich mich auf bestimmte Früche beschränkt, nämlich Orange, Banane, Apfel und Tomate. (Ob Tomate eine Fruch oder Gemüse ist, kann man sich natürlich darüber streiten.😅)

Als erstes habe ich die API mit einfachen URL Requests kennengelernt. Anschließend habe ich mich direkt mit Core ML beschäftigt und mir WWDC Sessions auf der Apple Developer App, Youtube Tutorials und die Dokumentation angeschaut. Es war sehr spannend zu sehen, was damit alles möglich ist. Da ich ein Model brauchte, das Objekte auf Fotos erkennen kann, machte ich mich auf die Suche nach Trainigsdaten. Ich wählte Adobe Stock als Quelle. Pro Frucht habe ich mir als erstes nur 10 Fotos ausgesucht und damit ein Model mit Create ML trainiert. 
Als Test, programmierte ich zuerst die Funktion, ein Foto aus der Foto Library auszuwählen, um anschließend das Foto dem Model als Input zu geben. Es war ziemlich cool, die ersten Ergebnisse zu sehen. 
Nun, ich fand das Auswählen von Fotos aus der Library etwas einfach(als Entwickler). Daher wollte ich eine Camera integrieren, was jedoch für mich die schwierigste Aufgabe dieses Projekts war. Zuerst hatte ich gehofft, dass es eine UIView dafür gibt. Musste, bzw. habe dann AVFoundation verwendet, was ich davor ebenfalls noch nie verwendet hatte. 
Was die Daten der Frucht angeht, wollte ich zuerst nur die Daten der Frucht allein laden und anzeigen. Da jedoch die API nicht nützliche Daten unverarbeitetr Lebensmittel hergibt, habe ich mich entschieden, einen URLRequest zu verwenden, der mit dem Namen der Frucht nach Produkten sucht.
Nachdem alles funktionierte, programmierte ich noch schicke Animationen mit SwiftUI, die die UX einen Feinschlief geben sollte. 
Am Ende habe ich mich entschieden ein neues Model zu trainieren, mit 15 Fotos pro Frucht.

Das Ergebnis war gut, ausreichend und besser als erwartet...für eine App, die in nicht einmal 2 Tagen entwickelt wurde.
Dieses Projekt hat mir eine bessere Aussicht gegeben, was man alles programmieren kann, und mich noch mehr motiviert, Apps zu entwickeln.
Es war ein sehr cooles Projekt und es ist sehr erstaunlich, was man alles schaffen kann, wenn man bei einem Mini Hackathon mitmacht, bei dem man um einiges produktiver und konzentrierter arbeitet.


