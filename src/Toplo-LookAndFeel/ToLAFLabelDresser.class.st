Class {
	#name : #ToLAFLabelDresser,
	#superclass : #ToAbstractLabelDresser,
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
ToLAFLabelDresser >> defaultSkin [

	^ ToDefaultLabelSkin new
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> initialState: aToLabel [ 

	super initialState: aToLabel.
	
	self skin foreground ifNotNil:[ :b | self foreground: b in: aToLabel ].
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
