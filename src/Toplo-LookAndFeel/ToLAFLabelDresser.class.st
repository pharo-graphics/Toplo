Class {
	#name : #ToLAFLabelDresser,
	#superclass : #ToAbstractLabelDresser,
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #accessing }
ToLAFLabelDresser >> defaultSkin [

	^ ToAbstractTheme current class skinFor: ToLabel type: ToAbstractSkin defaultType
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> initialState: aToLabel [ 

	super initialState: aToLabel.
	
	self foreground: self skin foreground in: aToLabel.
	self textAttributes: self skin textAttributes in: aToLabel
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> onInstalledIn: aToLabel [

	skin := aToLabel skin.
	self skin theme: aToLabel toTheme.

	super onInstalledIn: aToLabel
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> onUninstalledIn: aToLabel [

	super onUninstalledIn: aToLabel.
	skin := nil
]

{ #category : #accessing }
ToLAFLabelDresser >> skin [

	^ skin ifNil: [ skin := self defaultSkin ]
]
