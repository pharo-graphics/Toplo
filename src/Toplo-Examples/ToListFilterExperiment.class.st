Class {
	#name : #ToListFilterExperiment,
	#superclass : #Object,
	#instVars : [
		'filterField',
		'listElement',
		'dataFilter'
	],
	#category : 'Toplo-Examples'
}

{ #category : #'instance creation' }
ToListFilterExperiment class >> open [
	<script>
	self new open 
]

{ #category : #accessing }
ToListFilterExperiment >> listElement [

	^ listElement ifNil: [
		  listElement := ToListElement new
			                 matchParent;
			                 yourself ]
]

{ #category : #'instance creation' }
ToListFilterExperiment >> open [

	| pane |
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
	filterField editorDo: [ :ed |
		ed when: AlbTextEditedEvent do: [ self textUpdated ] ].

	self listElement data addAll:
		((Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ])
			 collect: [ :c | c name ]).

	listElement
		when: ToDataFilterResultEvent
		do: [ :event | listElement data filterResult: event data ].

	self listElement placeholderBuilder: [ :ph :e | | lab |
		lab := ToLabel new text: ('No result' asRopedText foreground: Color lightGray; fontSize: 24; yourself).
		lab matchParent.
		lab layout alignCenter.
		ph addChild: lab].

"	listElement data when: ToCollectionEmptinessEvent do: [ :event |
		listElement data
			ifEmpty: [ listElement showPlaceholder ]
			ifNotEmpty: [ listElement hidePlaceholder ] ]."
	pane openInInnerWindow 
]

{ #category : #'see class side' }
ToListFilterExperiment >> seeClassSide [ 
]

{ #category : #'instance creation' }
ToListFilterExperiment >> textUpdated [

	dataFilter dataFilterPattern: filterField text asString
]
