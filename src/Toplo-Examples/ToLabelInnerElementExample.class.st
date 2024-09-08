Class {
	#name : #ToLabelInnerElementExample,
	#superclass : #BlElement,
	#traits : 'TToLabelInnerElement',
	#classTraits : 'TToLabelInnerElement classTrait',
	#category : #'Toplo-Examples'
}

{ #category : #'t - label inner element' }
ToLabelInnerElementExample >> editorShortcutsIn: aLabel [

	^ { (BlShortcutWithAction new
			 combination: (BlKeyCombination primaryReturn or: BlKeyCombination return);
			 action: [  aLabel text: aLabel editor text. aLabel removeEditor ];
			 description: 'Accept the edited text';
			 name: 'Accept';
			 yourself).
	 (BlShortcutWithAction new
			 combination: (BlKeyCombination escape);
			 action: [  aLabel removeEditor ];
			 description: 'Escape from text editing';
			 name: 'Escape';
			 yourself) }
]

{ #category : #'t - label inner element' }
ToLabelInnerElementExample >> newEditorIn: aLabel [

	^ BlElement new background: Color yellow; yourself 
]

{ #category : #'t - label inner element' }
ToLabelInnerElementExample >> text [

	^ 'My text'
]

{ #category : #'t - label inner element' }
ToLabelInnerElementExample >> text: aText [

	
]
