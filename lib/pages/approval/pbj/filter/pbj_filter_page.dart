import 'package:modernland_signflow/bloc/common_approval_filter/common_approval_filter_bloc.dart';
import 'package:modernland_signflow/bloc/common_approval_filter/common_approval_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PBJFilterPage extends StatefulWidget {
  @override
  State<PBJFilterPage> createState() => _PBJFilterPageState();
}

class _PBJFilterPageState extends State<PBJFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filter Page'),
        ),
        body: BlocProvider(
          create: (context) => FilterBloc(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  return Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Choose Filter Option:'),
                        DropdownButtonFormField<String>(
                          value: state.selectedOption,
                          items: <String>[
                            'All',
                            'Tanggal Buat',
                            'Nomor Request'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            context
                                .read<FilterBloc>()
                                .setSelectedOption(newValue!);
                          },
                        ),
                        if (state.selectedOption == 'Tanggal Buat')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Start Date:'),
                              SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        state.startDateTime ?? DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    context
                                        .read<FilterBloc>()
                                        .setStartDateTime(selectedDate);
                                  }
                                },
                                child: Text(
                                  state.startDateTime != null
                                      ? '${state.startDateTime!.toLocal()}'
                                          .split(' ')[0]
                                      : 'Select Date',
                                ),
                              ),
                              SizedBox(height: 12),
                              Text('End Date:'),
                              SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        state.endDateTime ?? DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    context
                                        .read<FilterBloc>()
                                        .setEndDateTime(selectedDate);
                                  }
                                },
                                child: Text(
                                  state.endDateTime != null
                                      ? '${state.endDateTime!.toLocal()}'
                                          .split(' ')[0]
                                      : 'Select Date',
                                ),
                              ),
                            ],
                          ),
                        if (state.selectedOption == 'Nomor Request')
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Nomor Request'),
                            onChanged: (value) {},
                          ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            context.read<FilterBloc>().submitForm();
                          },
                          child: Text('Submit'),
                        ),
                        if (state.submitted)
                          AlertDialog(
                            title: Text('Submitted Values'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    'Selected Option: ${state.selectedOption}'),
                                if (state.selectedOption == 'Tanggal Buat')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Start Date: ${state.startDateTime}'),
                                      Text('End Date: ${state.endDateTime}'),
                                    ],
                                  ),
                                if (state.selectedOption == 'Nomor Request')
                                  Text('Nomor Request: ${state.nomorRequest}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
