&НаКлиенте
Перем ЗакрытиеФормыПодтверждено;

&НаКлиенте
Перем СохраненныеЗначенияРедаторов;

#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УИ_РедакторКодаСервер.ФормаПриСозданииНаСервере(ЭтотОбъект,"Ace");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "BODY", Элементы.РедакторBODY, "html");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "CSS", Элементы.РедакторCSS, "css");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "HEAD", Элементы.РедакторHEAD, "html");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "JS", Элементы.РедакторJS, "javascript");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "HTML", Элементы.РедакторРезультирующегоHTML, "html");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "БИБЛИОТЕКА", Элементы.РедакторБиблиотеки, "javascript");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "СФОРМИРОВАН", Элементы.РедакторСобытияДокументСформирован);
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "НАЖАТИЕ", Элементы.РедакторСобытияПриНажатии);

	ВыводКонсолиРезультирующегоHTML=ТекстПоляКонсолиРезультата();
	
	УИ_ОбщегоНазначения.ФормаИнструментаПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры
&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Не ЗакрытиеФормыПодтверждено Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ГруппаСтраницыРезультирующегоHTMLПриСменеСтраницы(Элемент, ТекущаяСтраница)
	Если ТекущаяСтраница = Элементы.ГруппаСтраницаКонсоль Тогда
		ОбновитьВыводКонсолиРезультата();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СохраненныеЗначенияРедаторов=Новый Структура;
	СохраненныеЗначенияРедаторов.Вставить("РедакторРезультирующегоHTML", "");
	СохраненныеЗначенияРедаторов.Вставить("РедакторBODY", "");
	СохраненныеЗначенияРедаторов.Вставить("РедакторHEAD", "");
	СохраненныеЗначенияРедаторов.Вставить("РедакторCSS", "");
	СохраненныеЗначенияРедаторов.Вставить("РедакторJS", "");
	СохраненныеЗначенияРедаторов.Вставить("РедакторСобытияДокументСформирован", "");
	СохраненныеЗначенияРедаторов.Вставить("РедакторСобытияПриНажатии", "");
	
	УИ_РедакторКодаКлиент.ФормаПриОткрытии(ЭтотОбъект, Новый ОписаниеОповещения("ПриОткрытииЗавершение",ЭтотОбъект));
	
КонецПроцедуры
#КонецОбласти

#Область СобытияЭлементовФормы

&НаКлиенте
Процедура РедакторBODYДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура РедакторHEADДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры
&НаКлиенте
Процедура РедакторCSSДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура РедакторJSДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура РедакторРезультирующегоHTMLДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура РедакторСобытияДокументСформированДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура РедакторСобытияПриНажатииДокументСформирован(Элемент)
	УстановитьТекстРедактораИзСохраненныхЗначений(Элемент);
КонецПроцедуры
&НаКлиенте
Процедура РезультирущийHTMLДокументСформирован(Элемент)
	ТекстАлготима=ТекстРедактораЭлемента(Элементы.РедакторСобытияДокументСформирован);
	Попытка
		Выполнить (ТекстАлготима);
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Сообщить(ОписаниеОшибки);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура РезультирущийHTMLПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	ТекстАлготима=ТекстРедактораЭлемента(Элементы.РедакторСобытияПриНажатии);
	Попытка
		Выполнить (ТекстАлготима);
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Сообщить(ОписаниеОшибки);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ПодключаемыеБиблиотекиПриАктивизацииСтроки(Элемент)
	ТекущиеДанные = Элементы.ПодключаемыеБиблиотеки.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Файл = Новый Файл(ТекущиеДанные.Путь);
	Если НРег(Файл.Расширение) <> ".css" Тогда
		РедакторБиблиотеки=УИ_РедакторКодаКлиент.ИмяФайлаРедактораAceДляЯзыка("css");
	Иначе
		РедакторБиблиотеки = УИ_РедакторКодаКлиент.ИмяФайлаРедактораAceДляЯзыка("javascript");
	КонецЕсли;

	ПодключитьОбработчикОжидания("УстановитьТекстРедактораБиблиотеки", 1, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПодключаемыеБиблиотекиПутьНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;

	ТекущиеДанные = Элементы.ПодключаемыеБиблиотеки.ТекущиеДанные;

	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораФайла.Фильтр = "*.*|*.*";
	ДиалогВыбораФайла.ПредварительныйПросмотр = Ложь; // по-умолчанию Истина
	ДиалогВыбораФайла.ПроверятьСуществованиеФайла = Истина;
	ДиалогВыбораФайла.Показать(Новый ОписаниеОповещения("ВыборПодключаемойБиблиотеки", ЭтаФорма,
		Новый Структура("ТекущиеДанные", ТекущиеДанные)));
КонецПроцедуры
&НаКлиенте
Процедура ГруппаРедакторHEADЗаголовокСворачиваниеНажатие(Элемент)
	ПереключитьВидимостьРедактора(Элементы.РедакторHEAD);
КонецПроцедуры

&НаКлиенте
Процедура ГруппаРедакторBODYЗаголовокСворачиваниеНажатие(Элемент)
	ПереключитьВидимостьРедактора(Элементы.РедакторBODY);
КонецПроцедуры

&НаКлиенте
Процедура ГруппаРедакторCSSЗаголовокСворачиваниеНажатие(Элемент)
	ПереключитьВидимостьРедактора(Элементы.РедакторCSS);
КонецПроцедуры

&НаКлиенте
Процедура ГруппаРедакторJSЗаголовокСворачиваниеНажатие(Элемент)
	ПереключитьВидимостьРедактора(Элементы.РедакторJS);
КонецПроцедуры
#КонецОбласти

#Область СобытияКомандФормы

&НаКлиенте
Процедура ОбновитьРезультирующийHTML(Команда)
	Если Элементы.ГруппаСтраницыРедактированияHTML.ТекущаяСтраница
		= Элементы.ГруппаСтраницаРежимаРедактированияВсеСразу Тогда

		ТекстCSS=ТекстРедактораЭлемента(Элементы.РедакторCSS);
		Если ЗначениеЗаполнено(ТекстCSS) Тогда
			ТекстCSS="
					 |<style type=""text/css"">
					 |" + ТекстCSS + "
									 |</style>";
		КонецЕсли;

		ТекстJS=ТекстРедактораЭлемента(Элементы.РедакторJS);
		Если ЗначениеЗаполнено(ТекстJS) Тогда
			ТекстJS="
					|<script>
					| " + ТекстJS + "
									|</script>";
		КонецЕсли;

		HTML=
		"<!DOCTYPE html>
		|<html lang=""ru"">";

		ТекстHEAD = ТекстРедактораЭлемента(Элементы.РедакторHEAD);
		ТекстHEAD = СтрЗаменить(ТекстHEAD, "<head>", "");
		ТекстHEAD = СтрЗаменить(ТекстHEAD, "</head>", "");

		Если СтрНайти(НРег(ТекстHEAD), "<head") = 0 Тогда
			HTML = HTML + "
						  |<head>";
		КонецЕсли;

		Если ЗначениеЗаполнено(ТекстHEAD) Тогда
			HTML = HTML + "
						  |
						  |" + СокрЛП(ТекстHEAD);
		КонецЕсли;
		Для Каждого СтрокаБиблиотеки Из ПодключаемыеБиблиотеки Цикл
			Файл=Новый Файл(СтрокаБиблиотеки.Путь);
			Если НРег(Файл.Расширение) = ".css" Тогда
				HTML=HTML + "
							|<link rel=""stylesheet"" href=""" + СтрокаБиблиотеки.Путь + """ "
					+ СтрокаБиблиотеки.ДополнительныеПараметры + " >";
			Иначе
				HTML=HTML + "
							|<script src=""" + СтрокаБиблиотеки.Путь + """ type=""text/javascript"" charset=""utf-8"" "
					+ СтрокаБиблиотеки.ДополнительныеПараметры + "></script>";
			КонецЕсли;
		КонецЦикла;

		Если Не ВключатьТекстCSSВТело Тогда
			HTML=HTML + ТекстCSS;
		КонецЕсли;
		Если Не ВключатьТекстJSВТело Тогда
			HTML=HTML + ТекстJS;
		КонецЕсли;

		Если СтрНайти(НРег(ТекстHEAD), "</head") = 0 Тогда
			HTML = HTML + "
						  |
						  |</head>";
		КонецЕсли;

		ТекстBODY = ТекстРедактораЭлемента(Элементы.РедакторBODY);
		ТекстBODY = СтрЗаменить(ТекстBODY, "<body>", "");
		ТекстBODY = СтрЗаменить(ТекстBODY, "</body>", "");

		Если СтрНайти(НРег(ТекстBODY), "<body") = 0 Тогда
			HTML = HTML + "
						  |
						  |<body>";
		КонецЕсли;

		Если ЗначениеЗаполнено(ТекстBODY) Тогда
			HTML=HTML + "
						| " + ТекстBODY;
		КонецЕсли;

		Если ВключатьТекстCSSВТело Тогда
			HTML=HTML + ТекстCSS;
		КонецЕсли;
		Если ВключатьТекстJSВТело Тогда
			HTML=HTML + ТекстJS;
		КонецЕсли;
		Если СтрНайти(НРег(ТекстBODY), "</body") = 0 Тогда
			HTML = HTML + "
						  |</body>";
		КонецЕсли;
		HTML=HTML + "
					|</html>";

		РезультирущийHTML=HTML;
		УстановитьТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML, РезультирущийHTML);
		УстановитьПоддержкуКонсолиВHTMLКод(РезультирущийHTML);

	Иначе
		HTML=ТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML);

		УстановитьПоддержкуКонсолиВHTMLКод(HTML);
		РезультирущийHTML=HTML;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТиповаяБиблиотекаBootstrap4(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://stackpath.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css",
		"integrity=""sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"" crossorigin=""anonymous""");
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://code.jquery.com/jquery-latest.min.js",
		"integrity=""sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"" crossorigin=""anonymous""");
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://cdn.jsdelivr.net/npm/popper.js/dist/umd/popper.min.js",
		"integrity=""sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"" crossorigin=""anonymous""");
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://stackpath.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js",
		"integrity=""sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"" crossorigin=""anonymous""");
КонецПроцедуры

&НаКлиенте
Процедура ТиповаяБиблиотекаJQuery(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://code.jquery.com/jquery-latest.min.js",
		"integrity=""sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"" crossorigin=""anonymous""");
КонецПроцедуры

&НаКлиенте
Процедура ТиповаяБиблиотекаFontAwesome(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки(
		"https://stackpath.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css", "");
КонецПроцедуры

&НаКлиенте
Процедура ТиповаяБиблиотекаPoperJS(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://unpkg.com/@popperjs/core@2", "");
КонецПроцедуры

&НаКлиенте
Процедура ТиповаяБиблиотекаResetCSS(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://unpkg.com/reset-css/reset.css", "");
КонецПроцедуры
&НаКлиенте
Процедура ТиповаяБиблиотекаAnimateCSS(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://cdn.jsdelivr.net/npm/animate.css/animate.min.css", "");
КонецПроцедуры

&НаКлиенте
Процедура ТиповаяБиблиотекаSocketIO(Команда)
	ДобавитьЗаписьВПодключаемыеБибилиотеки("https://cdn.jsdelivr.net/npm/socket.io-client/dist/socket.io.js", "");
КонецПроцедуры
&НаКлиенте
Процедура ОбновитьВыводКонсоли(Команда)
	ОбновитьВыводКонсолиРезультата();
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьСвернутьПолеПросмотраНаВсюФорму(Команда)
	ПолеПросмотраРазвернутоНаВсюФорму=Не ПолеПросмотраРазвернутоНаВсюФорму;

	Если ПолеПросмотраРазвернутоНаВсюФорму Тогда
		Элементы.ГруппаСтраницыРезультирующегоHTML.ТекущаяСтраница=Элементы.ГруппаПредставлениеРезультирующегоHTML;
		Элементы.ГруппаСтраницыРезультирующегоHTML.ОтображениеСтраниц=ОтображениеСтраницФормы.Нет;

		СохраненныеЗначенияРедаторов.РедакторРезультирующегоHTML= ТекстРедактораЭлемента(
			Элементы.РедакторРезультирующегоHTML);
		СохраненныеЗначенияРедаторов.РедакторBODY=ТекстРедактораЭлемента(Элементы.РедакторBODY);
		СохраненныеЗначенияРедаторов.РедакторHEAD= ТекстРедактораЭлемента(Элементы.РедакторHEAD);
		СохраненныеЗначенияРедаторов.РедакторCSS= ТекстРедактораЭлемента(Элементы.РедакторCSS);
		СохраненныеЗначенияРедаторов.РедакторJS= ТекстРедактораЭлемента(Элементы.РедакторJS);
		СохраненныеЗначенияРедаторов.РедакторСобытияДокументСформирован= ТекстРедактораЭлемента(
			Элементы.РедакторСобытияДокументСформирован);
		СохраненныеЗначенияРедаторов.РедакторСобытияПриНажатии= ТекстРедактораЭлемента(
			Элементы.РедакторСобытияПриНажатии);
	Иначе
		Элементы.ГруппаСтраницыРезультирующегоHTML.ОтображениеСтраниц=ОтображениеСтраницФормы.ЗакладкиСверху;
	КонецЕсли;

	Элементы.ГруппаСтраницыРедактированияHTML.Видимость=Не ПолеПросмотраРазвернутоНаВсюФорму;

КонецПроцедуры

&НаКлиенте
Процедура СохранитьБиблиотеку(Команда)
	ТекущиеДанные = Элементы.ПодключаемыеБиблиотеки.ТекущиеДанные;

	ЗаписьТекста = Новый ЗаписьТекста(ТекущиеДанные.Путь);
	ЗаписьТекста.Записать(ТекстРедактораЭлемента(Элементы.РедакторБиблиотеки));
	ЗаписьТекста.Закрыть();
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьОбщуюКомандуИнструментов(Команда) 
	УИ_ОбщегоНазначенияКлиент.Подключаемый_ВыполнитьОбщуюКомандуИнструментов(ЭтотОбъект, Команда);
КонецПроцедуры



#КонецОбласти

#Область СтандартныеПроцедурыИнструментов

&НаКлиенте
Процедура УстановитьПоддержкуКонсолиВHTMLКод(HTML)
	Если Не ИспользоватьКонсоль Тогда
		Возврат;
	КонецЕсли;
	
	ПозицияНачалаШапки=СтрНайти(НРег(HTML), "<head>");
	Если ПозицияНачалаШапки = 0 Тогда
		Возврат;
	КонецЕсли;
	НовыйТекст=Лев(HTML, ПозицияНачалаШапки + 5);
	НовыйТекст=НовыйТекст + ТекстСкриптаДляПоддержкиКонсоли();
	НовыйТекст=НовыйТекст + Сред(HTML, ПозицияНачалаШапки + 6);

	HTML=НовыйТекст;
КонецПроцедуры

&НаКлиенте
Функция ТекстСкриптаДляПоддержкиКонсоли()
	Текст=
	"<script type=""text/javascript"" charset=""utf-8"">
	|	console.output = []; // Из этого массива заберете все что вам нужно
	|	console.log = (function(log) {
	|		return function() {
	|			log.apply(console, arguments);
	|			console.output.push(arguments);
	|		}
	|	}(console.log));
	|
	|	function my__consoleOutput__string(){
	|		return JSON.stringify(console.output);
	|	}
	|</script>";
	Возврат Текст;
КонецФункции

&НаКлиенте
Функция СтруктураОписанияСохраняемогоФайла()
	Структура=УИ_ОбщегоНазначенияКлиент.ПустаяСтруктураОписанияВыбираемогоФайла();
	Структура.ИмяФайла=ИмяФайлаДанныхИнструмента;
	
//	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура, "Данные редактора HTML(*.bslhtml)", "bslhtml");
	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура, "Файл HTML(*.html)", "html");
	Возврат Структура;
КонецФункции
&НаКлиенте
Процедура ОткрытьФайл(Команда)
	УИ_ОбщегоНазначенияКлиент.ПрочитатьДанныеКонсолиИзФайла("РедактовHTML", СтруктураОписанияСохраняемогоФайла(),
		Новый ОписаниеОповещения("ОткрытьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	ИмяФайлаДанныхИнструмента = Результат.ИмяФайла;

	ДанныеФайла=ПолучитьИзВременногоХранилища(Результат.Адрес);

	Текст=Новый ТекстовыйДокумент;
	Текст.НачатьЧтение(Новый ОписаниеОповещения("ОткрытьФайлЗавершениеЧтенияТекста", ЭтаФорма, Новый Структура("Текст", Текст)), ДанныеФайла.ОткрытьПотокДляЧтения()); 
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлЗавершениеЧтенияТекста(ДополнительныеПараметры1) Экспорт
	
	Текст = ДополнительныеПараметры1.Текст;
	
	
	УстановитьТекстРедактораЭлемента(Элементы.РедакторCSS, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторBODY, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторHEAD, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторJS, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML, Текст.ПолучитьТекст());
	
	РезультирущийHTML="";
	
	УстановитьЗаголовок();
	
	Элементы.ГруппаСтраницыРедактированияHTML.ТекущаяСтраница = Элементы.ГруппаТекстРезультирующегоHTML; 
	ОбновитьРезультирующийHTML(Неопределено);

КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайл(Команда)
	СохранитьФайлНаДиск();
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлКак(Команда)
	СохранитьФайлНаДиск(Истина);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлНаДиск(СохранитьКак = Ложь)
	УИ_ОбщегоНазначенияКлиент.СохранитьДанныеКонсолиВФайл("РедактовHTML", СохранитьКак,
		СтруктураОписанияСохраняемогоФайла(), ТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML),
		Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлЗавершение(ИмяФайлаСохранения, ДополнительныеПараметры) Экспорт
	Если ИмяФайлаСохранения = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИмяФайлаСохранения) Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	ИмяФайлаДанныхИнструмента=ИмяФайлаСохранения;
	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура НовыйФайл(Команда)
	ИмяФайлаДанныхИнструмента="";

	УстановитьТекстРедактораЭлемента(Элементы.РедакторCSS, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторHEAD, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторBODY, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторJS, "");
	УстановитьТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML, "");

	ПодключаемыеБиблиотеки.Очистить();

	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьИнструмент(Команда)
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗакрытьИнструментЗавершение", ЭтаФорма), "Выйти из редактора?",
		РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьИнструментЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗакрытиеФормыПодтверждено = Истина;
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаголовок()
	Заголовок=ИмяФайлаДанныхИнструмента;
КонецПроцедуры

#КонецОбласти
#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура Подключаемый_ПолеРедактораДокументСформирован(Элемент)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLДокументСформирован(ЭтотОбъект, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеРедактораПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLПриНажатии(ЭтотОбъект, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте 
Процедура Подключаемый_РедакторКодаЗавершениеИнициализации() Экспорт
	
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВыводКонсолиРезультата()
	Попытка
		ДокРезультатView=Элементы.РезультирущийHTML.Документ.defaultView;

		ДокView=Элементы.ВыводКонсолиРезультирующегоHTML.Документ.defaultView;
		ДокView.clearConsole();
		ДокView.outputInfo(ДокРезультатView.my__consoleOutput__string());
	Исключение
	КонецПопытки;
КонецПроцедуры

&НаСервере
Функция ТекстПоляКонсолиРезультата()
	Текст=
	"<!DOCTYPE html>
	|<html>
	|    <head>
	|        <meta http-equiv=""content-type"" content=""text/html; charset=utf-8"" />
	|        <script type=""text/javascript"" src=""https://unpkg.com/html-console-output""></script>    
	|    </head>
	|    <body>
	|        <script type=""text/javascript"" charset=""utf-8"">
	|        	function clearConsole(){
	|				//document.body.innerHTML = "";
	|				var elems=document.getElementsByClassName('console-block');
	|				if (elems.length>0){
	|					elems[0].innerHTML='';
	|				}
	|			}
	|
	|			function outputInfo(info) {
	|				var objectInfo=JSON.parse(info);
	|				objectInfo.forEach(function(item, i, arr) {
	|					if (typeof item =='object') {
	|						var args=[]
	|						
	|						for (var key in item) {
	|							args.push(item[key]);
	|						}
	|						console.log.apply(console, args)
	|					} else {
	|						console.log(item)
	|					}
	|				});
	|			}
	|        </script>
	|    </body>
	|</html>";

	Возврат Текст;
КонецФункции
&НаКлиенте
Функция ТекстРедактораЭлемента(ЭлементПоляРедактора)
	Если Не ЭлементПоляРедактора.Видимость Тогда
		Возврат СохраненныеЗначенияРедаторов[ЭлементПоляРедактора.Имя];
	Иначе
		Возврат УИ_РедакторКодаКлиент.ТекстКодаРедактораЭлементаФормы(ЭтотОбъект,ЭлементПоляРедактора);
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура УстановитьТекстРедактораЭлемента(ЭлементПоляРедактора, ТекстУстановки)
	УИ_РедакторКодаКлиент.УстановитьТекстРедактораЭлементаФормы(ЭтотОбъект, ЭлементПоляРедактора, ТекстУстановки);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьЗаписьВПодключаемыеБибилиотеки(Путь, ДополнительныеПараметры)
	НС=ПодключаемыеБиблиотеки.Добавить();
	НС.Путь=Путь;
	НС.ДополнительныеПараметры=ДополнительныеПараметры;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекстРедактораИзСохраненныхЗначений(ЭлементРедатора)
	Если ТипЗнч(СохраненныеЗначенияРедаторов) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;

	Если Не СохраненныеЗначенияРедаторов.Свойство(ЭлементРедатора.Имя) Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(СохраненныеЗначенияРедаторов[ЭлементРедатора.Имя]) Тогда
		Возврат;
	КонецЕсли;

	УстановитьТекстРедактораЭлемента(ЭлементРедатора, СохраненныеЗначенияРедаторов[ЭлементРедатора.Имя]);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекстРедактораБиблиотеки()
	ТекущиеДанные = Элементы.ПодключаемыеБиблиотеки.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ТекущиеДанные.Путь) Тогда
		Возврат;
	КонецЕсли;

	ЧтениеТекста = Новый ЧтениеТекста(ТекущиеДанные.Путь);
	ТекстРедактораБиблиотеки = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();

	УстановитьТекстРедактораЭлемента(Элементы.РедакторБиблиотеки, ТекстРедактораБиблиотеки);
КонецПроцедуры
&НаКлиенте
Процедура ВыборПодключаемойБиблиотеки(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДополнительныеПараметры.ТекущиеДанные.Путь = ВыбранныеФайлы[0];
КонецПроцедуры // ВыборПодключаемойБиблиотеки()

&НаКлиенте
Процедура ПереключитьВидимостьРедактора(ЭлементРедактора)
	Если ЭлементРедактора.Видимость Тогда
		СохраненныеЗначенияРедаторов[ЭлементРедактора.Имя]=ТекстРедактораЭлемента(ЭлементРедактора);
	КонецЕсли;

	ЭлементРедактора.Видимость=Не ЭлементРедактора.Видимость;
КонецПроцедуры
#КонецОбласти

ЗакрытиеФормыПодтверждено=Ложь;