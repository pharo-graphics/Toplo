Class {
	#name : #ToMenuItemRowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'labelColumnFill',
		'iconColumnFill'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement whenLayoutedDo: [ self updateRowLayoutIn: anElement ].

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
				   labelColumnFill.
				   anElement icon } ]
		   ifFalse: [ 
			   { 
				   anElement icon.
				   iconColumnFill.
				   labelColumnFill.
				   anElement label } ]) select: #notNil
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> shouldCheckIconColumnFillIn: anElement [

	^ anElement isIconFirst
	
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> updateIconColumnFillIn: anElement [

	| w |
	" check if there a need to fill after the icon  "
	(w := anElement iconColumnWidth - anElement iconImage width) > 0 
		ifFalse: [ ^ self ].

	" ok, now measure the gap "
	iconColumnFill ifNotNil: [ " adapt the existing fill "
		iconColumnFill size x = w ifTrue: [ ^ self ].
		iconColumnFill size: w @ 0.
		^ self ].

	" first check, create the fill "
	iconColumnFill := BlElement new
		                  size: w @ 0;
		                  id: #'icon-column-fill'
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> updateRowLayoutIn: anElement [

	" first the label column only if it is justified "

	(labelColumnFill isNil and: [ anElement isLayoutJustified ]) ifTrue: [ 
		labelColumnFill := anElement privateMatchParentFill ].

	" then check the icon column "
	(self shouldCheckIconColumnFillIn: anElement) ifTrue: [ 
		self updateIconColumnFillIn: anElement ].

	anElement rowLayout: (self rowLayoutIn: anElement)
]
