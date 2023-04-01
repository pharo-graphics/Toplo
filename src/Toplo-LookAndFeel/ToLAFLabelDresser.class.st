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
ToLAFLabelDresser >> initialState: anElement [ 

	super initialState: anElement.
	
	self background: self skin background in: anElement.
	self border: self skin border in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> onInstalledIn: anElement [

	skin := anElement skin.
	self skin theme: anElement toTheme.

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLAFLabelDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	skin := nil
]

{ #category : #accessing }
ToLAFLabelDresser >> skin [

	^ skin ifNil: [ skin := self defaultSkin ]
]
