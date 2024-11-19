Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'bar'
	],
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #accessing }
ToContextMenu >> bar [ 

	^ bar
]

{ #category : #'t - menu window model' }
ToContextMenu >> closeWindow [

	self close
]

{ #category : #initialization }
ToContextMenu >> initialize [ 

	super initialize.
	self fitContent.
	bar := ToMenuBarElement new.
	self root addChild: bar
]

{ #category : #'t - menu window model' }
ToContextMenu >> isOpened [

	^ super isOpened
]

{ #category : #'t - menu window model' }
ToContextMenu >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu window model' }
ToContextMenu >> isTopMenu [

	^ true
]

{ #category : #accessing }
ToContextMenu >> itemHolder [

	^ self 
]

{ #category : #accessing }
ToContextMenu >> items [

	^ bar dataAccessor
]

{ #category : #'t - menu window model' }
ToContextMenu >> menuWindow [

	^ super menuWindow
]

{ #category : #'t - menu window model' }
ToContextMenu >> popupEvent: anEvent [

	^ super popupEvent: anEvent
]

{ #category : #'t - menu window model' }
ToContextMenu >> rootMenu [

	^ self 
]
