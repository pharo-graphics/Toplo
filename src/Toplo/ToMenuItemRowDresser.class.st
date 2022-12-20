Class {
	#name : #ToMenuItemRowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'interspace'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> exactInterspaceChangedIn: anElement [

	| w left |
	left := anElement isLabelFirst
		        ifTrue: [ anElement label ]
		        ifFalse: [ anElement icon ].

	" ok, now measure the gap "
	w := anElement leftColumnWidth - left width max: 0.

	interspace ifNotNil: [ " adapt the existing fill "
		interspace width = w ifTrue: [ ^ false ].
		interspace size: w @ 0.
		^ true ].

	" first check, create the fill "
	interspace := BlElement new
		                  size: w @ 0;
		                  id: #'icon-column-fill'.
	^ true
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> interspaceChangedIn: anElement [

	" first the label column only if it is justified "

	anElement isJustified ifTrue: [ 
		(self justifiedInterspaceChangedIn: anElement) ifTrue: [ ^ true ].
		^ false ].

	" then check the left column "
	^ self exactInterspaceChangedIn: anElement
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> justifiedInterspaceChangedIn: anElement [

	interspace ifNil: [ 
		interspace := anElement privateMatchParentFill.
		^ true ].
	^ false
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement whenLayoutedDo: [ self updateInterspaceIn: anElement ].
	anElement
		whenAnnouncement: ToMenuPresentationChangedAnnouncement
		do: [ 
			interspace := nil.
			self updateInterspaceIn: anElement ].
	anElement rowLayout: (self rowLayoutIn: anElement)
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> rowLayoutIn: anElement [

	^ (anElement isLabelFirst
		   ifTrue: [ 
			   { 
				   anElement label.
				   interspace.
				   anElement icon } ]
		   ifFalse: [ 
			   { 
				   anElement icon.
				   interspace.
				   anElement label } ]) select: #notNil
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> updateInterspaceIn: anElement [

	(self interspaceChangedIn: anElement) ifTrue: [ 
		anElement rowLayout: (self rowLayoutIn: anElement) ]
]
