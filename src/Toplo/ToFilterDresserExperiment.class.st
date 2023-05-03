Class {
	#name : #ToFilterDresserExperiment,
	#superclass : #Object,
	#instVars : [
		'filterField',
		'listElement'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToFilterDresserExperiment class >> open [
	<script>
	self new open 
]

{ #category : #'instance creation' }
ToFilterDresserExperiment >> open [

	| pane |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	listElement := ToListElement new.
	listElement margin: (BlInsets all: 2).
	filterField margin: (BlInsets all: 2).
	pane addChild: listElement.
	pane addChild: filterField.
	
	listElement data addAll:
		((Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ])
			 collect: [ :c | c name ]).


	listElement addDresser: ToDataFilterDresser new.
	filterField whenTextEditedDo: [ self textUpdated ].
	listElement when: ToDataFilteredEvent do: [ :event |
		listElement data removeAll.
		listElement data addAll: event data ].
	pane openInOBlSpace
]

{ #category : #'see class side' }
ToFilterDresserExperiment >> seeClassSide [ 
]

{ #category : #'instance creation' }
ToFilterDresserExperiment >> textUpdated [

	listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: filterField text asString)
]
