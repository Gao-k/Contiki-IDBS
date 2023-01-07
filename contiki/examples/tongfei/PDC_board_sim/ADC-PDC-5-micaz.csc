<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[APPS_DIR]/mrm</project>
  <project EXPORT="discard">[APPS_DIR]/mspsim</project>
  <project EXPORT="discard">[APPS_DIR]/avrora</project>
  <project EXPORT="discard">[APPS_DIR]/serial_socket</project>
  <project EXPORT="discard">[APPS_DIR]/collect-view</project>
  <project EXPORT="discard">[APPS_DIR]/powertracker</project>
  <simulation>
    <title>My simulation</title>
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
      <source>[CONTIKI_DIR]/examples/tongfei/PDC_board_sim/hello-world.c</source>
      <commands>make hello-world.elf TARGET=micaz</commands>
      <firmware>[CONTIKI_DIR]/examples/tongfei/PDC_board_sim/hello-world.elf</firmware>
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
        <x>29.954906835984566</x>
        <y>66.96739387478384</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>1</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaClock
        <deviation>1.0</deviation>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>53.34307596971802</x>
        <y>78.83449770477563</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>2</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaClock
        <deviation>1.0</deviation>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>66.54565118160626</x>
        <y>68.79738403189124</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>3</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaClock
        <deviation>1.0</deviation>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>43.84853371906716</x>
        <y>49.90955915042235</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>4</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaClock
        <deviation>1.0</deviation>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>60.74569465393564</x>
        <y>59.229162426346036</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaZID
        <id>5</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.avrmote.interfaces.MicaClock
        <deviation>1.0</deviation>
      </interface_config>
      <motetype_identifier>micaz1</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    org.contikios.cooja.plugins.SimControl
    <width>280</width>
    <z>2</z>
    <height>160</height>
    <location_x>400</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.Visualizer
    <plugin_config>
      <moterelations>true</moterelations>
      <skin>org.contikios.cooja.plugins.skins.IDVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.MoteTypeVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.UDGMVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.GridVisualizerSkin</skin>
      <viewport>2.368454442369675 0.0 0.0 2.368454442369675 26.63666758186663 53.14014430520288</viewport>
    </plugin_config>
    <width>400</width>
    <z>0</z>
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
    <width>1520</width>
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
      <mote>2</mote>
      <mote>3</mote>
      <mote>4</mote>
      <showRadioRXTX />
      <showRadioHW />
      <showLEDs />
      <zoomfactor>5000.0</zoomfactor>
    </plugin_config>
    <width>1920</width>
    <z>1</z>
    <height>278</height>
    <location_x>17</location_x>
    <location_y>728</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.Notes
    <plugin_config>
      <notes>Enter notes here</notes>
      <decorations>true</decorations>
    </plugin_config>
    <width>1240</width>
    <z>3</z>
    <height>160</height>
    <location_x>680</location_x>
    <location_y>0</location_y>
  </plugin>
</simconf>

