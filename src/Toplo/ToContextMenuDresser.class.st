Class {
	#name : #ToContextMenuDresser,
	#superclass : #ToMenuWindowDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> mouseDownOutside: anEvent receivedIn: aMenuWindow [

	| origEventTarget |
	origEventTarget := anEvent originalEvent currentTarget.
	origEventTarget ifNil: [ ^ super mouseDownOutside: anEvent receivedIn: aMenuWindow].
	(origEventTarget hasInParentChain: aMenuWindow widget) ifTrue: [ 
		" mouse down on the context menu widget, let's close the menu "
		^ anEvent currentTarget close ].
	super mouseDownOutside: anEvent receivedIn: aMenuWindow
]

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
]
