# Memory UVM Testbench

Parametrik bir **memory** tasarımı (DUT) için **sıfırdan yazılmış UVM verification testbench**.
RTL (`design.sv`) hazır alınmış; doğrulama tarafının tamamı kendi dosya yapımla kurulmuştur.

## Yapı
- `src/` → RTL (design.sv)
- `sim/` → verification dosyaları: interface, seq_item, sequence, sequencer,
  driver, monitor, agent, scoreboard, env, test, top

## Bileşen hiyerarşisi (aşağıdan yukarı)
interface → seq_item → sequence → sequencer → driver → monitor → agent →
scoreboard → env → test → tbench_top

## Çalıştırma (DSim)
mem_vf kök klasöründe:
## Sonuç
Simülasyon yazma + okuma işlemlerini test eder, scoreboard beklenen ile geleni
karşılaştırır ve **UVM_ERROR: 0** ile tamamlanır.

## Notlar
Süreç ve satır satır açıklamalar için `UVM_Testbench_Notlarim.pdf` dosyasına bakınız.
