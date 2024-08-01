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

    
    transition add_trip(destination: field, start_date: field, end_date: field) -> Trip {
        let new_trip = Trip { destination, start_date, end_date, booked: false };
        let trip_id = hash.bhp256(destination);
        set new_trip into trips[trip_id];
        output new_trip
    }

    
    transition remove_trip(destination: field) {
        let trip_id = hash.bhp256(destination);
        remove trips[trip_id];
    }

    
    transition book_trip(destination: field) {
        let trip_id = hash.bhp256(destination);
        get trips[trip_id] into trip;
        trip.booked = true;
        set trip into trips[trip_id];
    }

    
    transition update_dates(destination: field, start_date: field, end_date: field) {
        let trip_id = hash.bhp256(destination);
        get trips[trip_id] into trip;
        trip.start_date = start_date;
        trip.end_date = end_date;
        set trip into trips[trip_id];
    }

    
    function get_all_trips() -> [Trip] {
        let mut all_trips: [Trip] = [];
        for trip in trips {
            all_trips.push(trip);
        }
        return all_trips;
    }
}
