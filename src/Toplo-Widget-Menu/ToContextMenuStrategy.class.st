Class {
	#name : #ToContextMenuStrategy,
	#superclass : #ToPopupWindowStrategy,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #initialization }
ToContextMenuStrategy >> defaultPositionHook [

	^ [ :window :theElement :event | event position ]
]
