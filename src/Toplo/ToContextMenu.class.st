Class {
	#name : #ToContextMenu,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToMenu',
	#classTraits : 'TToWidget classTrait + TToMenu classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToContextMenu >> initialize [

	super initialize.

	self initializeMenu 
]

{ #category : #'t - menu initialization' }
ToContextMenu >> menuWindowClass [

	^ ToContextMenuWindow
]

{ #category : #'t - menu window' }
ToContextMenu >> parentMenuWindow [

	^ nil
]

{ #category : #accessing }
ToContextMenu >> widget: aWidget [

	self menuWindow widget: aWidget
]
