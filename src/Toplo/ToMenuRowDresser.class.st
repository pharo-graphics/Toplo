Class {
	#name : #ToMenuRowDresser,
	#superclass : #ToMenuItemRowDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuRowDresser >> rowLayoutIn: anElement [

	anElement isSubmenu ifTrue: [ 
		^ { 
			  anElement icon.
			  iconColumnFill.
			  labelColumnFill.
			  anElement label.
			  anElement privateMatchParentFill.
			  anElement rightIcon } select: #notNil ].

	^ super rowLayoutIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToMenuRowDresser >> shouldCheckIconColumnFillIn: anElement [

	^ anElement icon hasInnerImage 
]
