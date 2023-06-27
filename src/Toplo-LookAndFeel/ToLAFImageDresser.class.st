Class {
	#name : #ToLAFImageDresser,
	#superclass : #ToAbstractImageDresser,
	#traits : 'TToSkinnableElementDresser',
	#classTraits : 'TToSkinnableElementDresser classTrait',
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFImageDresser >> defaultToElementClass [

	^ ToImage
]

{ #category : #'events handling' }
ToLAFImageDresser >> hover: anElement event: anEvent [

	"update main element"
	self foreground: self skin foregroundHover in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLAFImageDresser >> initialState: aToImage [ 

	super initialState: aToImage.
	
	self foreground: self skin foreground in: aToImage
]

{ #category : #accessing }
ToLAFImageDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	self flag:'Labordep this is dirty, need to find a better solution'.
	^ aSkin isKindOf: ToAbstractImageSkin
]

{ #category : #'events handling' }
ToLAFImageDresser >> leftPressed: anElement event: aBlMouseDownEvent [ 
	
	"update main element"
	self foreground: self skin foregroundPressed in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLAFImageDresser >> onInstalledIn: aToImage [

	skin := aToImage skin.
	self skin theme: aToImage toTheme.
	self haveCompatibleSkin ifFalse:[^ self].	

	super onInstalledIn: aToImage.
	self skin onInstalledIn: aToImage.
]

{ #category : #'api - install/uninstall  hook' }
ToLAFImageDresser >> onUninstalledIn: aToImage [

	self skin onUninstalledIn: aToImage.
	super onUninstalledIn: aToImage.
	skin := nil
]
