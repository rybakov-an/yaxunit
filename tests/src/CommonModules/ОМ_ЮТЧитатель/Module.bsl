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
	
	ЮТТесты
		.ДобавитьТест("ИсполняемыеСценарииМодуля")
		.ДобавитьТестовыйНабор("ЭтоТестовыйМодуль", "Параметризированный, 1,2")
			.ДобавитьТест("ЭтоТестовыйМодуль")
				.СПараметрами("ОМ_ЮТЧитатель", Истина)
				.СПараметрами("ОМ_ЮТУтверждения", Истина)
				.СПараметрами("ОМ_Мокито", Истина)
				.СПараметрами("ЮТЧитатель", Ложь)
		.ДобавитьТестовыйНабор("ЗагрузкаТестов")
			.ДобавитьКлиентскийТест("ЗагрузитьТесты")
	;
	
КонецПроцедуры

Процедура ЗагрузитьТесты() Экспорт
	
	ПараметрыЗапуска = ЮТФабрика.ПараметрыЗапуска();
	ПараметрыЗапуска.filter.extensions = Неопределено;
	ПараметрыЗапуска.filter.modules = ЮТОбщий.ЗначениеВМассиве("ОМ_ЮТЧитатель");
	
	Наборы = ЮТЧитатель.ЗагрузитьТесты(ПараметрыЗапуска);
	ЮТест.ОжидаетЧто(Наборы, "Прочитанные наборы")
		.ИмеетТип("Массив")
		.ИмеетДлину(1);
	
	НаборМодуля = Наборы[0];
	
	ЮТест.ОжидаетЧто(НаборМодуля, "Набор тестов ОМ_ЮТЧитатель")
		.ИмеетТип("Структура")
		.Свойство("МетаданныеМодуля").ИмеетТип("Структура")
		.Свойство("НаборыТестов").ИмеетТип("Массив");
	
	МетаданныеМодуля = НаборМодуля.МетаданныеМодуля;
	ЮТест.ОжидаетЧто(МетаданныеМодуля, "Метаданные модуля")
		.Заполнено()
		.ИмеетТип("Структура")
		.Свойство("Имя").Равно("ОМ_ЮТЧитатель")
		.Свойство("КлиентОбычноеПриложение").Равно(Истина)
		.Свойство("КлиентУправляемоеПриложение").Равно(Истина)
		.Свойство("ВызовСервера").Равно(Ложь)
		.Свойство("ПолноеИмя").Равно("tests.ОМ_ЮТЧитатель")
		.Свойство("Сервер").Равно(Ложь);
	
	НаборыТестов = НаборМодуля.НаборыТестов;
	
	ЮТест.ОжидаетЧто(НаборыТестов, "Наборы тестов модуля")
		.ИмеетТип("Массив")
		.ИмеетДлину(3);
	
	ЮТест.ОжидаетЧто(НаборыТестов[0], "Набор тестов по умолчанию")
		.ИмеетТип("Структура")
		.Свойство("Имя").Равно("ОМ_ЮТЧитатель")
		.Свойство("Представление").Равно("ОМ_ЮТЧитатель")
		.Свойство("Ошибки").ИмеетТип("Массив").НеЗаполнено()
		.Свойство("Теги").ИмеетТип("Массив").НеЗаполнено()
		.Свойство("Тесты").ИмеетТип("Массив").ИмеетДлину(1);
	
	Тесты = НаборыТестов[0].Тесты;
	
	ЮТест.ОжидаетЧто(Тесты.Количество(), "Количество тестов модуля")
		.БольшеИлиРавно(1);
	
	ЮТест.ОжидаетЧто(Тесты[0], "Первый тест")
		.Свойство("Имя").Равно("ИсполняемыеСценарииМодуля")
		.Свойство("Представление").НеЗаполнено()
		.Свойство("Теги").Равно(Новый Массив())
		.Свойство("КонтекстВызова").Равно(ЮТОбщий.ЗначениеВМассиве("КлиентУправляемоеПриложение"));
	
	ПараметрыЗапуска = ЮТФабрика.ПараметрыЗапуска();
	ПараметрыЗапуска.filter.extensions = ЮТОбщий.ЗначениеВМассиве("tests");
	
	Наборы = ЮТЧитатель.ЗагрузитьТесты(ПараметрыЗапуска);
	ЮТест.ОжидаетЧто(Наборы, "Прочитанные наборы расширения tests")
		.ИмеетДлину(18);
	
КонецПроцедуры

Процедура ИсполняемыеСценарииМодуля() Экспорт
	
	МетаданныеМодуля = Новый Структура;
	МетаданныеМодуля.Вставить("Имя", "ОМ_ЮТЧитатель");
	МетаданныеМодуля.Вставить("КлиентУправляемоеПриложение", Истина);
	МетаданныеМодуля.Вставить("КлиентОбычноеПриложение", Истина);
	МетаданныеМодуля.Вставить("Клиент", Ложь);
	МетаданныеМодуля.Вставить("Сервер", Истина);
	МетаданныеМодуля.Вставить("ВызовСервера", Ложь);
	
	ЮТФильтрация.УстановитьКонтекст(Новый Структура("filter", Новый Структура));
	ОписаниеМодуля = ЮТЧитатель.ИсполняемыеСценарииМодуля(МетаданныеМодуля);
	
	ЮТест.ОжидаетЧто(ОписаниеМодуля, "ОписаниеМодуля")
		.ИмеетТип("Структура")
		.Свойство("НаборыТестов")
		.ИмеетДлину(3)
		.Элемент("НаборыТестов[0]").ИмеетТип("Структура")
		.Элемент("НаборыТестов[1]").ИмеетТип("Структура")
		.Элемент("НаборыТестов[2]").ИмеетТип("Структура")
	;
	Сценарии = ОписаниеМодуля.НаборыТестов;
	
	НаборПоУмолчанию = Сценарии[0];
	НаборЭтоТестовыйМодуль = Сценарии[1];
	НаборЗагрузкаТестов = Сценарии[2];
	
	ЮТест.ОжидаетЧто(НаборПоУмолчанию, "Набор по умолчанию")
		.Свойство("Имя").Равно("ОМ_ЮТЧитатель")
		.Свойство("Представление").Равно("ОМ_ЮТЧитатель")
		.Свойство("Теги").ИмеетДлину(0)
		.Свойство("Тесты").ИмеетДлину(1)
		.Свойство("Тесты[0].Имя").Равно("ИсполняемыеСценарииМодуля")
		.Свойство("Тесты[0].Представление").НеЗаполнено()
		.Свойство("Тесты[0].Теги").ИмеетДлину(0)
		.Свойство("Тесты[0].КонтекстВызова").Равно(ЮТОбщий.ЗначениеВМассиве("Сервер", "КлиентУправляемоеПриложение"))
	;
	
	ЮТест.ОжидаетЧто(НаборЗагрузкаТестов, "Набор 'ЗагрузкаТестов'")
		.Свойство("Имя").Равно("ЗагрузкаТестов")
		.Свойство("Тесты").ИмеетДлину(1)
		.Свойство("Тесты[0].Имя").Равно("ЗагрузитьТесты")
		.Свойство("Тесты[0].КонтекстВызова").Равно(ЮТОбщий.ЗначениеВМассиве("КлиентУправляемоеПриложение"))
	;
	
	ЮТест.ОжидаетЧто(НаборЭтоТестовыйМодуль, "Набор 'ЭтоТестовыйМодуль'")
		.Свойство("Имя").Равно("ЭтоТестовыйМодуль")
		.Свойство("Тесты").ИмеетДлину(4)
		.Свойство("Теги").ИмеетДлину(3)
		;
	
КонецПроцедуры

Процедура ЭтоТестовыйМодуль(ИмяМодуля, ЭтоТестовый) Экспорт
	
	ОписаниеМодуля = ЮТМетаданныеСервер.МетаданныеМодуля(ИмяМодуля);
	ЮТест.ОжидаетЧто(ЮТЧитатель.ЭтоТестовыйМодуль(ОписаниеМодуля), "Проверка модуля " + ИмяМодуля)
		.Равно(ЭтоТестовый);
	
КонецПроцедуры

#КонецОбласти