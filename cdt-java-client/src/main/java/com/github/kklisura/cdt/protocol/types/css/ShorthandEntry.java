package com.github.kklisura.cdt.protocol.types.css;

/*-
 * #%L
 * cdt-java-client
 * %%
 * Copyright (C) 2018 Kenan Klisura
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

import com.github.kklisura.cdt.protocol.support.annotations.Optional;

public class ShorthandEntry {

  private String name;

  private String value;

  @Optional private Boolean important;

  /** Shorthand name. */
  public String getName() {
    return name;
  }

  /** Shorthand name. */
  public void setName(String name) {
    this.name = name;
  }

  /** Shorthand value. */
  public String getValue() {
    return value;
  }

  /** Shorthand value. */
  public void setValue(String value) {
    this.value = value;
  }

  /** Whether the property has "!important" annotation (implies <code>false</code> if absent). */
  public Boolean getImportant() {
    return important;
  }

  /** Whether the property has "!important" annotation (implies <code>false</code> if absent). */
  public void setImportant(Boolean important) {
    this.important = important;
  }
}