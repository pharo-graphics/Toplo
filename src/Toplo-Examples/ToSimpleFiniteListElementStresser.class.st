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
				  list deferOrValue: [ list dataAccessor addAll: (1 to: size) ].

				  self storeRunnedAction:
					  'list dataAccessor add: 1 afterIndex: 36.'.
				  list deferOrValue: [ list dataAccessor add: 1 afterIndex: 36 ].

				  self storeRunnedAction:
					  'list selecter selectIndexes: #( 65 93 25 85 71 4 57 59 38 26 7 63 58 76 58 62 33 6 51 67 25 ).'.
				  list deferOrValue: [
						  list selecter selectIndexes:
							  #( 65 93 25 85 71 4 57 59 38 26 7 63 58 76 58 62 33 6 51 67
							     25 ) ].

				  self storeRunnedAction: 'list dataAccessor at: 8 put: 2.'.
				  list deferOrValue: [ list dataAccessor at: 8 put: 2 ].

				  self storeRunnedAction: 'list selecter selectIndex: 69 to: 54.'.
				  list deferOrValue: [ list selecter selectIndex: 69 to: 54 ].
				
				  self storeRunnedAction: 'list selecter selectAll.'.
				  list deferOrValue: [ list selecter selectAll ].

				  self storeRunnedAction: 'list dataAccessor removeAll.'.
				  list deferOrValue: [ list dataAccessor removeAll ].


				  self storeRunnedAction: 'list selecter deselectAll.'.
				  list deferOrValue: [ list selecter deselectAll ].

				  self storeRunnedAction: 'list dataAccessor removeAll.'.
				  list deferOrValue: [ list dataAccessor removeAll ].

				  self storeRunnedAction:
					  'list dataAccessor add: 3 afterIndex: 0.'.
				  list deferOrValue: [ list dataAccessor add: 3 afterIndex: 0 ].

				  self storeRunnedAction: 'list selecter deselectIndexes: #( 1 ).'.
				  list deferOrValue: [ list selecter deselectIndexes: #( 1 ) ].
				
				  self storeRunnedAction:
					  'list selecter selectOnlyIndexes: #( 1 ).'.
				  list deferOrValue: [ list selecter selectOnlyIndexes: #( 1 ) ].

				  self storeRunnedAction:
					  'list dataAccessor addAll: (1 to: size).'.
				  list deferOrValue: [ list dataAccessor addAll: (1 to: size) ].

				  self storeRunnedAction: 'list selecter selectAll.'.
				  list deferOrValue: [ list selecter selectAll ].
				
				  self storeRunnedAction: 'list selecter deselectAll.'.
				  list deferOrValue: [ list selecter deselectAll ].
				
				  self storeRunnedAction: 'list selecter selectIndex: 3.'.
				  list deferOrValue: [ list selecter selectIndex: 3 ] ].
		  endTime := DateAndTime now.
		  (endTime - startTime) asDuration traceCr ]
]
