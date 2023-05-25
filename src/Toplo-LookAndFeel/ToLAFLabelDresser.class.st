Class {
	#name : #ToLAFLabelDresser,
	#superclass : #ToAbstractLabelDresser,
	#traits : 'TToSkinnableElementDresser',
	#classTraits : 'TToSkinnableElementDresser classTrait',
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFLabelDresser >> defaultToElementClass [

	^ ToLabel
]

{ #category : #'events handling' }
ToLAFLabelDresser >> hover: anElement event: anEvent [

	"update main element"
	self foreground: self skin foregroundHover in: anElement.
	self textAttributes: self skin textAttributesHover in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> initialState: aToLabel [ 

	super initialState: aToLabel.
	
	self foreground: self skin foreground in: aToLabel.
	self textAttributes: self skin textAttributes in: aToLabel
]

{ #category : #accessing }
ToLAFLabelDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	self flag:'Labordep this is dirty, need to find a better solution'.
	^ aSkin isKindOf: ToAbstractLabelSkin
]

{ #category : #'events handling' }
ToLAFLabelDresser >> leftPressed: aToLabel event: aBlMouseDownEvent [ 
	
	"do nothing"
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> onInstalledIn: aToLabel [

	skin := aToLabel skin.
	self skin theme: aToLabel toTheme.
	self haveCompatibleSkin ifFalse:[^ self].	

	super onInstalledIn: aToLabel.
	self skin onInstalledIn: aToLabel.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> onUninstalledIn: aToLabel [

	self skin onUninstalledIn: aToLabel.
	super onUninstalledIn: aToLabel.
	skin := nil
]
