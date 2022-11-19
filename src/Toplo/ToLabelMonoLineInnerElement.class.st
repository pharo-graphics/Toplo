Class {
	#name : #ToLabelMonoLineInnerElement,
	#superclass : #BlAttributedTextElement,
	#traits : 'TToLabelInnerElement + TOBlLayoutResizable',
	#classTraits : 'TToLabelInnerElement classTrait + TOBlLayoutResizable classTrait',
	#category : #'Toplo-Widget-Labels'
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
			 action: [  aLabel removeEditor ];
			 description: 'Escape from text editing';
			 name: 'Escape';
			 yourself).
		 }
]

{ #category : #'api - editor' }
ToLabelMonoLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToTextField new dresser: ToLabelEditorBasicDresser new.
	(self editorShortcutsIn: aLabel) do: [ :s | ed innerElement editor addEditorShortcut: s ].
	self flag: 'ed matchParent here leads to a Pharo crash'.
	ed fitContent.
	^ ed
]

{ #category : #'event handling' }
ToLabelMonoLineInnerElement >> textChanged [

	super textChanged.
	self dispatchEvent: (ToTextReplacedEvent new text: self text)
	
]
