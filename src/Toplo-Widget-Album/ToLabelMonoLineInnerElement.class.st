Class {
	#name : #ToLabelMonoLineInnerElement,
	#superclass : #BlTextElement,
	#traits : 'TToLabelInnerElement + TBlLayoutResizable',
	#classTraits : 'TToLabelInnerElement classTrait + TBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'api - editor' }
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
	" Need Label measurement to ensure right vertical alignement with labels/menus "
	self labelMeasurement.
	self preventMouseEvents
]

{ #category : #'api - editor' }
ToLabelMonoLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToTextField new.
	(self editorShortcutsIn: aLabel) do: [ :s | ed editor addEditorShortcut: s ].
	^ ed
]

{ #category : #'t - resizeable' }
ToLabelMonoLineInnerElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	| hr vr |
	hr := self constraints horizontal resizer.
	vr := self constraints vertical resizer.
	aBlock value: self constraints.
	(hr = self constraints horizontal resizer and: [
		 vr = self constraints vertical resizer ]) ifTrue: [ ^ self ].
	self dispatchEvent: ToLayoutConstraintsChangedEvent new.
	self requestLayout
]

{ #category : #'api - text accessing' }
ToLabelMonoLineInnerElement >> text [

	^ super text
]

{ #category : #'api - text accessing' }
ToLabelMonoLineInnerElement >> text: aText [

	super text: aText.
	self forceLocalLayout 
]
