Class {
	#name : #ToSimpleFiniteListElementStresser,
	#superclass : #ToFiniteListElementStresser,
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #running }
ToSimpleFiniteListElementStresser class >> run [

	<script>

	self new run

]

{ #category : #accessing }
ToSimpleFiniteListElementStresser >> maxRound [

	^ 200
]

{ #category : #running }
ToSimpleFiniteListElementStresser >> processBlock [

	^ [
		  | startTime endTime |
		  startTime := DateAndTime now.
		  round := 0.
		  self maxRound timesRepeat: [
				  round := round + 1.
				  self storeRunnedAction:
					  'list dataAccessor addAll: (1 to: size).'.
				  list inUIProcessDo: [ list dataAccessor addAll: (1 to: size) ].

				  self storeRunnedAction:
					  'list dataAccessor add: 1 afterIndex: 36.'.
				  list inUIProcessDo: [ list dataAccessor add: 1 afterIndex: 36 ].

				  self storeRunnedAction:
					  'list selecter selectIndexes: #( 65 93 25 85 71 4 57 59 38 26 7 63 58 76 58 62 33 6 51 67 25 ).'.
				  list inUIProcessDo: [
						  list selecter selectIndexes:
							  #( 65 93 25 85 71 4 57 59 38 26 7 63 58 76 58 62 33 6 51 67
							     25 ) ].

				  self storeRunnedAction: 'list dataAccessor at: 8 put: 2.'.
				  list inUIProcessDo: [ list dataAccessor at: 8 put: 2 ].

				  self storeRunnedAction: 'list selecter selectIndex: 69 to: 54.'.
				  list inUIProcessDo: [ list selecter selectIndex: 69 to: 54 ].
				
				  self storeRunnedAction: 'list selecter selectAll.'.
				  list inUIProcessDo: [ list selecter selectAll ].

				  self storeRunnedAction: 'list dataAccessor removeAll.'.
				  list inUIProcessDo: [ list dataAccessor removeAll ].


				  self storeRunnedAction: 'list selecter deselectAll.'.
				  list inUIProcessDo: [ list selecter deselectAll ].

				  self storeRunnedAction: 'list dataAccessor removeAll.'.
				  list inUIProcessDo: [ list dataAccessor removeAll ].

				  self storeRunnedAction:
					  'list dataAccessor add: 3 afterIndex: 0.'.
				  list inUIProcessDo: [ list dataAccessor add: 3 afterIndex: 0 ].

				  self storeRunnedAction: 'list selecter deselectIndexes: #( 1 ).'.
				  list inUIProcessDo: [ list selecter deselectIndexes: #( 1 ) ].
				
				  self storeRunnedAction:
					  'list selecter selectOnlyIndexes: #( 1 ).'.
				  list inUIProcessDo: [ list selecter selectOnlyIndexes: #( 1 ) ].

				  self storeRunnedAction:
					  'list dataAccessor addAll: (1 to: size).'.
				  list inUIProcessDo: [ list dataAccessor addAll: (1 to: size) ].

				  self storeRunnedAction: 'list selecter selectAll.'.
				  list inUIProcessDo: [ list selecter selectAll ].
				
				  self storeRunnedAction: 'list selecter deselectAll.'.
				  list inUIProcessDo: [ list selecter deselectAll ].
				
				  self storeRunnedAction: 'list selecter selectIndex: 3.'.
				  list inUIProcessDo: [ list selecter selectIndex: 3 ] ].
		  endTime := DateAndTime now.
		  (endTime - startTime) asDuration traceCr ]
]
