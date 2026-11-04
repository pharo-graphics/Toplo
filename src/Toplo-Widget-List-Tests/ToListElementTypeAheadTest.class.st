"
I test the type-ahead feature of ToBasicListElement (see ToListTypeAheadEventHandler).
The list holds #('apple' 'banana' 'blueberry') in a headless testing space; typed text is simulated with the event simulator on the focused list.
"
Class {
	#name : #ToListElementTypeAheadTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'list'
	],
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #private }
ToListElementTypeAheadTest >> pressKey: aKeyboardKey [

	list requestFocus.
	list eventSimulator keyPress: aKeyboardKey
]

{ #category : #private }
ToListElementTypeAheadTest >> selectedIndexes [

	^ list selectionModel selectedIndexes asArray
]

{ #category : #running }
ToListElementTypeAheadTest >> setUp [

	super setUp.
	list := ToListElement new.
	list nodeBuilder: [ :node :dataItem :holder | node addChild: (ToLabel text: dataItem asString) ].
	space root addChild: list.
	space deferAndSettle: [
			list matchParent.
			list dataAccessor addAll: #( 'apple' 'banana' 'blueberry' ) ]
]

{ #category : #tests }
ToListElementTypeAheadTest >> testBackspaceRemovesLastCharacter [

	list enableTypeAhead.
	self type: 'bl'.
	self assert: self selectedIndexes equals: #( 3 ).

	self pressKey: KeyboardKey backspace.
	self assert: list typeAheadHandler pattern equals: 'b'.
	self assert: list typeAheadHandler overlay label text asString equals: 'b'.
	self assert: self selectedIndexes equals: #( 2 )
]

{ #category : #tests }
ToListElementTypeAheadTest >> testDisableTypeAhead [

	list enableTypeAhead.
	list disableTypeAhead.
	self deny: list isTypeAheadEnabled.

	self type: 'b'.
	self assert: self selectedIndexes isEmpty
]

{ #category : #tests }
ToListElementTypeAheadTest >> testEscapeResetsTypeAhead [

	list enableTypeAhead.
	self type: 'bl'.
	self assert: list typeAheadHandler overlay isNotNil.

	self pressKey: KeyboardKey escape.
	self assert: list typeAheadHandler pattern equals: ''.
	self assert: list typeAheadHandler overlay isNil.
	"The selection made by type-ahead is kept"
	self assert: self selectedIndexes equals: #( 3 )
]

{ #category : #tests }
ToListElementTypeAheadTest >> testKeyDownAimedAtChildIsIgnored [

	| child |
	list enableTypeAhead.
	self type: 'bl'.
	child := list innerElement nodeContainers first.
	BlEvent
		fireEvent: (BlKeyDownEvent new
				 key: KeyboardKey backspace;
				 yourself)
		target: child.
	self assert: list typeAheadHandler pattern equals: 'bl'.
	self assert: self selectedIndexes equals: #( 3 )
]

{ #category : #tests }
ToListElementTypeAheadTest >> testTypeAheadIsCaseInsensitive [

	list enableTypeAhead.
	self type: 'BA'.
	self assert: self selectedIndexes equals: #( 2 )
]

{ #category : #tests }
ToListElementTypeAheadTest >> testTypeAheadIsDisabledByDefault [

	self deny: list isTypeAheadEnabled.
	self assert: list typeAheadHandler isNil.

	"Typing on a list without type-ahead selects nothing"
	self type: 'b'.
	self assert: self selectedIndexes isEmpty
]

{ #category : #tests }
ToListElementTypeAheadTest >> testTypeAheadKeepsSelectionWhenNoMatch [

	list enableTypeAhead.
	self type: 'bl'.
	self assert: self selectedIndexes equals: #( 3 ).

	"'blx' matches nothing: the selection is unchanged"
	self type: 'x'.
	self assert: self selectedIndexes equals: #( 3 ).
	self assert: list typeAheadHandler pattern equals: 'blx'
]

{ #category : #tests }
ToListElementTypeAheadTest >> testTypeAheadSelectsFirstMatchFromTop [

	list enableTypeAhead.
	self type: 'b'.
	self assert: self selectedIndexes equals: #( 2 ).

	"'bl' no longer matches 'banana': the search restarts from the top"
	self type: 'l'.
	self assert: self selectedIndexes equals: #( 3 ).
	self assert: list typeAheadHandler pattern equals: 'bl'.
	self assert: list typeAheadHandler overlay label text asString equals: 'bl'
]

{ #category : #tests }
ToListElementTypeAheadTest >> testTypeAheadWithCustomMatcher [

	list typeAheadMatcher: [ :item :pattern | item includesSubstring: pattern ].
	self assert: list isTypeAheadEnabled.

	"'err' is inside 'blueberry' only"
	self type: 'err'.
	self assert: self selectedIndexes equals: #( 3 )
]

{ #category : #private }
ToListElementTypeAheadTest >> type: aString [
	"Simulate the user typing aString on the focused list"

	list requestFocus.
	list eventSimulator textInput: aString
]
