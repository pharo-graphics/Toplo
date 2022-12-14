Class {
	#name : #ToLabelInnerElementExample,
	#superclass : #BlElement,
	#traits : 'TToLabelInnerElement',
	#classTraits : 'TToLabelInnerElement classTrait',
	#category : #'Toplo-Examples'
}

{ #category : #'api - editor' }
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

{ #category : #'api - editor' }
ToLabelInnerElementExample >> newEditorIn: aLabel [

	^ BlElement new background: Color yellow; yourself 
]

{ #category : #'api - text accessing' }
ToLabelInnerElementExample >> text [

	^ 'My text'
]

{ #category : #'api - text accessing' }
ToLabelInnerElementExample >> text: aText [

	
]
