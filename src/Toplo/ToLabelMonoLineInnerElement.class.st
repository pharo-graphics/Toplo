Class {
	#name : #ToLabelMonoLineInnerElement,
	#superclass : #BlAttributedTextElement,
	#traits : 'TToLabelInnerElement + TBlLayoutResizable',
	#classTraits : 'TToLabelInnerElement classTrait + TBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Label'
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
	ed := ToTextField new dresser: (ToLabelEditorDresser label: aLabel).
	(self editorShortcutsIn: aLabel) do: [ :s | ed editor addEditorShortcut: s ].
	^ ed
]

{ #category : #'event handling' }
ToLabelMonoLineInnerElement >> textChanged [

	super textChanged.
	self dispatchEvent: (ToTextReplacedEvent new text: self text)
	
]
