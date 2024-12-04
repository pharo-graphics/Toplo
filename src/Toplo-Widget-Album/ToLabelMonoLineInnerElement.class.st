Class {
	#name : #ToLabelMonoLineInnerElement,
	#superclass : #BlTextElement,
	#traits : 'TToLabelInnerElement',
	#classTraits : 'TToLabelInnerElement classTrait',
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'t - label inner element' }
ToLabelMonoLineInnerElement >> editorShortcutsIn: aLabel [

	^ { (BlShortcutWithAction new
			 combination: ((BlKeyCombination primaryReturn or: BlKeyCombination return) or: BlKeyCombination primaryS );
			 action: [  aLabel text: aLabel editor text. aLabel removeEditor ];
			 description: 'Accept the edited text';
			 name: 'Accept';
			 yourself).
	 (BlShortcutWithAction new
			 combination: (BlKeyCombination escape or: BlKeyCombination primaryL);
			 action: [ :e | aLabel removeEditor ];
			 description: 'Escape from text editing';
			 name: 'Escape';
			 yourself).
		 }
]

{ #category : #initialization }
ToLabelMonoLineInnerElement >> initialize [ 

	super initialize.
	self preventMouseEvents
]

{ #category : #initialization }
ToLabelMonoLineInnerElement >> initializeMeasurement [

	" Need Label measurement to ensure right vertical alignement with labels/menus "
	self flag: 'To be checked'.
	"self labelMeasurement."
	self editorMeasurement
]

{ #category : #'t - label inner element' }
ToLabelMonoLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToTextField new.
	(self editorShortcutsIn: aLabel) do: [ :s | ed editor addEditorShortcut: s ].
	^ ed
]

{ #category : #layout }
ToLabelMonoLineInnerElement >> requestLayout: xc [

	super requestLayout: xc.

	"Prev = self ifTrue: [ 	self class name trace. ' ' trace. self traceCr. self haltOnCount: 3 ].
	Prev := self"
]

{ #category : #'t - label inner element' }
ToLabelMonoLineInnerElement >> text [

	^ super text
]

{ #category : #'t - label inner element' }
ToLabelMonoLineInnerElement >> text: aText [

	super text: aText
]
