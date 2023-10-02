Class {
	#name : #ToFilterDresserOnListWithPopupExperiment2,
	#superclass : #Object,
	#instVars : [
		'filterField',
		'listElement',
		'filterWin'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 class >> open [
	<script>
	self new open 
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> close [

	filterWin ifNil: [ ^ self ].
	filterWin close.
	filterWin := nil.
	filterField removeFromParent.
	self listElement requestFocus
	
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> filterResultPlaceholder [

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
ToFilterDresserOnListWithPopupExperiment2 >> listElement [

	^ listElement ifNil: [
		  listElement := ToListElement new
			                 matchParent;
			                 yourself ]
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> open [

	| pane filler |
	pane := ToPane vertical
		        matchParent;
		        yourself.
	filler := ToElement new
		          background: Color lightGray;
		          hMatchParent;
		          vExact: 80;
		          yourself.
	filler margin: (BlInsets all: 2).
	listElement := ToListElement new matchParent.
	listElement addEventHandler: (BlEventHandler
			 on: BlTextInputEvent
			 do: [ :anEvent | self popupTextFieldWith: anEvent text ]).

	listElement addShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination escape;
			 action: [ self requestCancel ];
			 description: 'Cancel edition';
			 name: 'Cancel';
			 yourself).

	listElement margin: (BlInsets all: 2).
	pane addChild: listElement.
	pane addChild: filler.

	listElement placeholder: self startPlaceholder.
	listElement placeholder elevation:
		(BlRelativeElevation elevation: SmallInteger maxVal).
	listElement showPlaceholder.

	self listElement addDresser: ToListElementFilter new.

	listElement when: ToDataFilterResultEvent do: [ :event |
			listElement selectIndexes: event indexes ].

	listElement requestFocus.
	pane openInSpace
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> popupTextFieldWith: aString [

	filterWin ifNotNil: [
		filterField inserter
			text: aString asRopedText;
			apply.
		self textUpdated.
		filterField requestFocus.
		^ self ].

	filterWin := ToAnchoredWindow new
		             positionHook: [ :win :event |
			             win widget bounds inSpace bounds bottomLeft ];
		             yourself.

	filterField ifNil: [
		filterField := ToTextField new withLineWrapping.
		filterField addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination escape;
				 action: [ self requestCancel ];
				 description: 'Cancel edition';
				 name: 'Cancel';
				 yourself).
		filterField whenTextEditedDo: [ :event |
			self textUpdated.
			event text ifEmpty: [ self close ] ] ].

	filterField width: self listElement width.
	self listElement when: ToDataFilterResultEvent do: [ :ann |
		ann indexes
			ifEmpty: [ filterField text foreground: Color red ]
			ifNotEmpty: [ filterField text foreground: Color black ] ].

	filterField text: aString.
	filterField requestFocus.
	filterField navigator
		moveTo: aString size;
		apply.

	filterWin root addChild: filterField.
	filterWin widget: self listElement.
	filterWin popup.
	self textUpdated
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> requestCancel [

	filterWin ifNil: [  ^ self ].
	self listElement dispatchEvent: (ToDataFilterRequest new pattern: '').
	self close
]

{ #category : #'see class side' }
ToFilterDresserOnListWithPopupExperiment2 >> seeClassSide [ 
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> startPlaceholder [

	| placeholder lab but |
	placeholder := ToPane vertical.
	placeholder layout cellSpacing: 10.
	placeholder margin: (BlInsets all: 20).
	placeholder matchParent.
	placeholder addChild: (lab := ToLabel new text:
			        ('No element - click to get data' asRopedText foreground:
				         Color red)).
	placeholder addChild: (but := ToButtonDep new labelText: 'Fetch data').
	lab constraintsDo: [ :c | c linear horizontal alignCenter ].
	but constraintsDo: [ :c | c linear horizontal alignCenter ].
	but whenClickedDo: [
		self listElement data addAll:
			(((Smalltalk allClassesAndTraits sorted: [ :a :b | a name < b name ])
				 collect: [ :c | c name ]) "copyFrom: 1 to: 1000").
		self listElement placeholder: self filterResultPlaceholder.
		self listElement requestFocus.
		self listElement whenLayoutedDoOnce: [ self textUpdated ] ].
	^ placeholder
]

{ #category : #'instance creation' }
ToFilterDresserOnListWithPopupExperiment2 >> textUpdated [

	filterField ifNil: [ ^self ].
	listElement dispatchEvent: (ToDataFilterRequest new pattern: filterField text asString)
]
