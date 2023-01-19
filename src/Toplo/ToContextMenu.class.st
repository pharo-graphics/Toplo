Class {
	#name : #ToContextMenu,
	#superclass : #Object,
	#traits : 'TToMenu',
	#classTraits : 'TToMenu classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToContextMenu >> initialize [

	super initialize.
	self initializeMenu 
]

{ #category : #'t - menu initialization' }
ToContextMenu >> newMenuWindow [

	^ ToContextMenuWindow new
]

{ #category : #'t - menu window' }
ToContextMenu >> parentMenuWindow [

	^ nil
]

{ #category : #accessing }
ToContextMenu >> widget: aWidget [

	self menuWindow widget: aWidget
]
