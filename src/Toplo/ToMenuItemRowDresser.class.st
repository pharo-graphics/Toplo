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
	
	" get the left side element "
	left := anElement isLabelFirst
		        ifTrue: [ anElement label ]
		        ifFalse: [ anElement icon ].

	" now measure the gap according to leftColumnWidth "
	w := anElement leftColumnWidth - left width max: 0.

	interspace ifNotNil: [ " adapt the existing fill "
		interspace width = w ifTrue: [ ^ false ].
		interspace size: w @ 0.
		^ true ].

	" first pass, create the fill "
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
	anElement whenLayoutedDoOnce: [ self updateInterspaceIn: anElement ].
	anElement
		whenAnnouncement: ToMenuPresentationChangedAnnouncement
		do: [ 
			interspace := nil.
			self updateInterspaceIn: anElement ].
	anElement rowLayingOut: (self rowLayingOutIn: anElement)
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> rowLayingOutIn: anElement [

	| la ic |
	la := anElement label text
		      ifNotEmpty: [ anElement label ]
		      ifEmpty: [ nil ].
	ic := anElement icon hasInnerImage
		      ifTrue: [ anElement icon ]
		      ifFalse: [ nil ].

	^ (anElement isLabelFirst
		   ifTrue: [ 
			   { 
				   la.
				   interspace.
				   ic } ]
		   ifFalse: [ 
			   { 
				   ic.
				   interspace.
				   la } ]) select: #notNil
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> updateInterspaceIn: anElement [

'x' traceCr.
	(self interspaceChangedIn: anElement) ifFalse: [ ^ self ].
	
	" update the row laying out in the element "
	anElement rowLayingOut: (self rowLayingOutIn: anElement).
	" launch a second pass to finalize the laying out "
	anElement whenLayoutedDoOnce: [ self updateInterspaceIn: anElement ]
]
