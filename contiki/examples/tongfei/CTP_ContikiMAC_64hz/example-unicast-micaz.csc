<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[APPS_DIR]/mrm</project>
  <project EXPORT="discard">[APPS_DIR]/mspsim</project>
  <project EXPORT="discard">[APPS_DIR]/avrora</project>
  <project EXPORT="discard">[APPS_DIR]/serial_socket</project>
  <project EXPORT="discard">[APPS_DIR]/collect-view</project>
  <project EXPORT="discard">[APPS_DIR]/powertracker</project>
  <simulation>
    <title>example-unicast-micaz</title>
    <randomseed>123456</randomseed>
    <motedelay_us>1000000</motedelay_us>
    <radiomedium>
      org.contikios.cooja.radiomediums.UDGM
      <transmitting_range>50.0</transmitting_range>
      <interference_range>100.0</interference_range>
      <success_ratio_tx>1.0</success_ratio_tx>
      <success_ratio_rx>1.0</success_ratio_rx>
    </radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      org.contikios.cooja.avrmote.MicaZMoteType
      <identifier>micaz1</identifier>
      <description>MicaZ Mote Type #micaz1</description>
      <source>[CONTIKI_DIR]/examples/rime/example-unicast.c</source>
      <commands>make example-unicast.elf TARGET=micaz</commands>
      <firmware>[CONTIKI_DIR]/examples/rime/example-unicast.elf</firmware>
      <moteinterface>org.contikios.cooja.interfaces.Position</moteinterface>
      <moteinterface>org.contikios.cooja.avrmote.interfaces.MicaZID</moteinterface>
      <moteinterface>org.contikios.cooja.avrmote.interfaces.MicaZLED</moteinterface>
      <moteinterface>org.contikios.cooja.avrmote.interfaces.MicaZRadio</moteinterface>
      <moteinterface>org.contikios.cooja.avrmote.interfaces.MicaClock</moteinterface>
      <moteinterface>org.contikios.cooja.avrmote.interfaces.MicaSerial</moteinterface>
      <moteinterface>org.contikios.cooja.interfaces.Mote2MoteRelations</moteinterface>
      <moteinterface>org.contikios.cooja.interfaces.MoteAttributes</moteinterface>
    </motetype>
    <mote>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>66.88554711633192</x>
        <y>37.735574597016225</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>1</id>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>57.074829920942626</x>
        <y>43.05230459904968</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>2</id>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    org.contikios.cooja.plugins.SimControl
    <width>280</width>
    <z>0</z>
    <height>160</height>
    <location_x>400</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.Visualizer
    <plugin_config>
      <moterelations>true</moterelations>
      <viewport>10.165135814346085 0.0 0.0 10.165135814346085 -524.5370340907217 -173.1098820904972</viewport>
    </plugin_config>
    <width>400</width>
    <z>1</z>
    <height>400</height>
    <location_x>1</location_x>
    <location_y>1</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.LogListener
    <plugin_config>
      <filter />
      <formatted_time />
      <coloring />
    </plugin_config>
    <width>1473</width>
    <z>4</z>
    <height>240</height>
    <location_x>400</location_x>
    <location_y>160</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.TimeLine
    <plugin_config>
      <mote>0</mote>
      <mote>1</mote>
      <showRadioRXTX />
      <showRadioHW />
      <showLEDs />
      <zoomfactor>500.0</zoomfactor>
    </plugin_config>
    <width>1873</width>
    <z>3</z>
    <height>166</height>
    <location_x>0</location_x>
    <location_y>782</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.Notes
    <plugin_config>
      <notes>Enter notes here</notes>
      <decorations>true</decorations>
    </plugin_config>
    <width>1193</width>
    <z>2</z>
    <height>160</height>
    <location_x>680</location_x>
    <location_y>0</location_y>
  </plugin>
</simconf>

