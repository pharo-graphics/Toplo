Class {
	#name : #ToSeparatorMenuItemDresser,
	#superclass : #ToDresser,
	#instVars : [
		'popupHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToSeparatorMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement addChild: (ToElement new
			 background: Color lightGray;
			 constraintsDo: [ :c | 
				 c horizontal matchParent.
				 c vertical exact: 1 ]).
	anElement padding: (BlInsets all: 2)
]
