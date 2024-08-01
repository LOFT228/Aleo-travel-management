# Aleo-travel-management
Для програма створена для менеджменту над поїздками(етальніше в readme)


    program travel_management_kx0d8ki.aleo {

    struct Trip {
        destination: field,
        start_date: field,
        end_date: field,
        booked: bool
    }

    mapping trips:
        key as field.public,
        value as Trip.public;

    // Додає нову подорож до списку.
    transition add_trip(destination: field, start_date: field, end_date: field) -> Trip {
        let new_trip = Trip { destination, start_date, end_date, booked: false };
        let trip_id = hash.bhp256(destination);
        set new_trip into trips[trip_id];
        output new_trip
    }

    // Видаляє подорож зі списку.
    transition remove_trip(destination: field) {
        let trip_id = hash.bhp256(destination);
        remove trips[trip_id];
    }

    // Відмічає подорож як заброньовану.
    transition book_trip(destination: field) {
        let trip_id = hash.bhp256(destination);
        get trips[trip_id] into trip;
        trip.booked = true;
        set trip into trips[trip_id];
    }

    // Оновлює дати подорожі.
    transition update_dates(destination: field, start_date: field, end_date: field) {
        let trip_id = hash.bhp256(destination);
        get trips[trip_id] into trip;
        trip.start_date = start_date;
        trip.end_date = end_date;
        set trip into trips[trip_id];
    }

    // Отримує список всіх подорожей.
    function get_all_trips() -> [Trip] {
        let mut all_trips: [Trip] = [];
        for trip in trips {
            all_trips.push(trip);
        }
        return all_trips;
    }


Опис 5и функцій:
add_trip: Додає нову подорож до списку з інформацією про місце призначення, дати початку та завершення подорожі.
book_trip: Оновлює статус подорожі
cancel_trip: Скасовує подорож
get_trip_details: Повертає деталі подорожі за унікальним ідентифікатором
list_trips: Виводить всі зареєстровані подорожі.

===================================
Офіційний сайт https://www.aleo.org/ Leo: https://leo-lang.org/ Discord https://discord.gg/aleohq Twitter https://twitter.com/AleoHQ GitHub https://github.com/AleoHQ
