Class {
	#name : #ToFilterDresserOnListExperiment,
	#superclass : #Object,
	#instVars : [
		'filterField',
		'listElement',
		'dataFilter'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToFilterDresserOnListExperiment class >> open [
	<script>
	self new open 
]

{ #category : #'instance creation' }
ToFilterDresserOnListExperiment >> filterResultPlaceholder [

	| placeholder lab |
	placeholder := ToPane vertical.
	placeholder matchParent.
	lab := ToLabel new text: ('No result' asRopedText foreground: Color lightGray).
	lab matchParent.
	lab layout alignCenter.
	placeholder addChild: lab.
	^ placeholder
]

{ #category : #accessing }
ToFilterDresserOnListExperiment >> listElement [

	^ listElement ifNil: [
		  listElement := ToListElement new
			                 matchParent;
			                 yourself ]
]

{ #category : #'instance creation' }
ToFilterDresserOnListExperiment >> open [

	| pane  |
	pane := ToPane vertical
		        matchParent;
		        yourself.
	filterField := ToTextField new withLineWrapping.
	listElement := ToListElement new matchParent.
	listElement margin: (BlInsets all: 2).
	filterField margin: (BlInsets all: 2).
	pane addChild: listElement.
	pane addChild: filterField.

	dataFilter := ToListElementFilter new.
	listElement dataFilter: dataFilter.
	filterField editorDo: [:ed | ed when: AlbTextEditedEvent do: [ self textUpdated ] ].

	listElement placeholder: self startPlaceholder.
	listElement placeholder elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	listElement showPlaceholder.

	listElement when: ToDataFilterResultEvent do: [ :event |
		listElement data filterResult: event data ].
	pane openInSpace
]

{ #category : #'see class side' }
ToFilterDresserOnListExperiment >> seeClassSide [ 
]

{ #category : #'instance creation' }
ToFilterDresserOnListExperiment >> startPlaceholder [

	| placeholder lab but |
	placeholder := ToPane vertical.
	placeholder layout cellSpacing: 10.
	placeholder margin: (BlInsets all: 20).
	placeholder matchParent.
	placeholder addChild: (lab := ToLabel new text:
			        ('No element - click to get data' asRopedText foreground:
				         Color red)).
	placeholder addChild: (but := ToButton new labelText: 'Fetch data').
	lab constraintsDo: [ :c | c linear horizontal alignCenter ].
	but constraintsDo: [ :c | c linear horizontal alignCenter ].
	but whenClickedDo: [
		self listElement data addAll:
			((Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ])
				 collect: [ :c | c name ]).
		self listElement placeholder: self filterResultPlaceholder ].
	^ placeholder
]

{ #category : #'instance creation' }
ToFilterDresserOnListExperiment >> textUpdated [

	dataFilter dataFilterPattern: filterField text asString
]
