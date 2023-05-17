//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты.ВТранзакции().УдалениеТестовыхДанных()
		.ДобавитьТест("ЗаполнитьСправочник")
		.ДобавитьТест("ЗаполнитьДокумент")
		.ДобавитьТест("ФикцияОбязательныхПолей")
	;
		
КонецПроцедуры

Процедура ЗаполнитьСправочник() Экспорт
	
#Если Клиент Тогда
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары");
#Иначе
	Конструктор = ЮТест.Данные().КонструкторОбъекта(Справочники.Товары);
#КонецЕсли
	
	Конструктор
		.Фикция("Наименование")
		.Фикция("Артикул")
		.Фикция("Поставщик")
		.Фикция("Вид");
	
	ДанныеОбъекта = Конструктор.ДанныеОбъекта();
	ЮТест.ОжидаетЧто(ДанныеОбъекта, "Данные создаваемого объекта")
		.Свойство("Наименование").Заполнено()
		.Свойство("Артикул").Заполнено()
		.Свойство("Поставщик").Заполнено()
		.Свойство("Вид").Заполнено();
	
	Ссылка = Конструктор.Записать();
#Если НЕ Клиент Тогда
	ЮТест.ОжидаетЧто(Ссылка, "Созданный объект")
		.Заполнено()
		.ИмеетТип("СправочникСсылка.Товары")
		.Свойство("Наименование").Заполнено().Равно(ДанныеОбъекта.Наименование)
		.Свойство("Артикул").Заполнено().Равно(ДанныеОбъекта.Артикул)
		.Свойство("Поставщик").Заполнено().Равно(ДанныеОбъекта.Поставщик)
		.Свойство("Вид").Заполнено().Равно(ДанныеОбъекта.Вид);
#КонецЕсли
	
КонецПроцедуры

Процедура ЗаполнитьДокумент() Экспорт
	
#Если Клиент Тогда
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Документы.ПриходТовара");
#Иначе
	Конструктор = ЮТест.Данные().КонструкторОбъекта(Документы.ПриходТовара);
#КонецЕсли
	
	Ссылка = Конструктор
		.Фикция("Поставщик")
		.Фикция("Склад")
		.Фикция("Валюта")
		.Фикция("Организация")
		.ТабличнаяЧасть("Товары")
		.ДобавитьСтроку()
			.Фикция("Товар")
			.Установить("Цена", ЮТест.Данные().СлучайноеПоложительноеЧисло(9999, 2))
			.Установить("Количество", ЮТест.Данные().СлучайноеПоложительноеЧисло(20))
			.Установить("Сумма", Конструктор.ДанныеСтроки().Цена * Конструктор.ДанныеСтроки().Количество)
		.ДобавитьСтроку()
			.Фикция("Товар")
			.Установить("Цена", ЮТест.Данные().СлучайноеПоложительноеЧисло(9999, 2))
			.Установить("Количество", ЮТест.Данные().СлучайноеПоложительноеЧисло(20))
			.Установить("Сумма", Конструктор.ДанныеСтроки().Цена * Конструктор.ДанныеСтроки().Количество)
		.Провести();
	
#Если НЕ Клиент Тогда
	ЮТест.ОжидаетЧто(Ссылка, "Созданный объект")
		.Заполнено()
		.ИмеетТип("ДокументСсылка.ПриходТовара")
		.Свойство("Номер").Заполнено()
		.Свойство("Поставщик").Заполнено()
		.Свойство("Склад").Заполнено()
		.Свойство("Товары").ИмеетДлину(2)
			.Свойство("Товары[0].Товар").Заполнено()
			.Свойство("Товары[0].Цена").Заполнено()
			.Свойство("Товары[0].Количество").Заполнено()
			.Свойство("Товары[0].Сумма").Заполнено()
			.Свойство("Товары[1].Товар").Заполнено()
			.Свойство("Товары[1].Цена").Заполнено()
			.Свойство("Товары[1].Количество").Заполнено()
			.Свойство("Товары[1].Сумма").Заполнено()
		.Свойство("Проведен").ЭтоИстина()
	;
#КонецЕсли

КонецПроцедуры

Процедура ФикцияОбязательныхПолей() Экспорт
	
	Данные = ЮТест.Данные().КонструкторОбъекта("Справочники.Контрагенты")
		.ФикцияОбязательныхПолей()
		.ДанныеОбъекта();
	
	ЮТест.ОжидаетЧто(Данные)
		.ИмеетДлину(2)
		.Свойство("ВидЦен").Заполнено()
		.Свойство("Наименование").Заполнено();
	
	Данные = ЮТест.Данные().КонструкторОбъекта("Документы.ПриходТовара")
		.ФикцияОбязательныхПолей()
		.ТабличнаяЧасть("Товары")
			.ДобавитьСтроку()
			.ФикцияОбязательныхПолей()
		.ДанныеОбъекта();
	
	ЮТест.ОжидаетЧто(Данные)
		.ИмеетДлину(6)
		.Свойство("Дата").Заполнено()
		.Свойство("Поставщик").Заполнено()
		.Свойство("Склад").Заполнено()
		.Свойство("Валюта").Заполнено()
		.Свойство("Организация").Заполнено()
		.Свойство("Товары").Заполнено()
		.Свойство("Товары[0]").ИмеетДлину(4);
	
	Данные = ЮТест.Данные().КонструкторОбъекта("РегистрыСведений.КурсыВалют")
		.ФикцияОбязательныхПолей()
		.ДанныеОбъекта();
	
	ЮТест.ОжидаетЧто(Данные)
		.ИмеетДлину(3)
		.Свойство("Период").Заполнено()
		.Свойство("Валюта").Заполнено()
		.Свойство("Курс").Заполнено();
КонецПроцедуры

#КонецОбласти
