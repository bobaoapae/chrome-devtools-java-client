package com.github.kklisura.cdt.protocol.events.media;

/*-
 * #%L
 * cdt-java-client
 * %%
 * Copyright (C) 2018 - 2020 Kenan Klisura
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */

import com.github.kklisura.cdt.protocol.types.media.PlayerProperty;

import java.util.List;

/**
 * This can be called multiple times, and can be used to set / override / remove player properties.
 * A null propValue indicates removal.
 */
public class PlayerPropertiesChanged {

  private String playerId;

  private List<PlayerProperty> properties;

  public String getPlayerId() {
    return playerId;
  }

  public void setPlayerId(String playerId) {
    this.playerId = playerId;
  }

  public List<PlayerProperty> getProperties() {
    return properties;
  }

  public void setProperties(List<PlayerProperty> properties) {
    this.properties = properties;
  }
}
