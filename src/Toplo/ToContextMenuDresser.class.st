Class {
	#name : #ToContextMenuDresser,
	#superclass : #ToMenuWindowDresser,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToContextMenuDresser >> mouseOutside: anEvent in: aMenuWindow [

	| origEventTarget |
	origEventTarget := anEvent originalEvent currentTarget.
	origEventTarget ifNil: [
		^ super mouseOutside: anEvent in: aMenuWindow ].
	(origEventTarget hasInParentChain: aMenuWindow widget) ifTrue: [
		| delay |
		" mouse up on the context menu widget, let's close the menu 
		if the delay between opening and mouse up is short enough"
		delay := anEvent originalEvent timestamp - aMenuWindow popupTimestamp.
		delay > aMenuWindow autoCloseOnMouseUpDelay ifTrue: [
			^ anEvent currentTarget close ] ].
	super mouseOutside: anEvent in: aMenuWindow
]
