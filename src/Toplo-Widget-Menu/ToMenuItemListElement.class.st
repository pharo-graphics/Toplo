Class {
	#name : #ToMenuItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuItemListElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToMenuItemListElement >> defaultNodeManagerClass [

	^ ToMenuNodeManager
]

{ #category : #initialization }
ToMenuItemListElement >> initialize [

	super initialize.
	self nodeWrapping: true.
	self fitContent.
	self vertical: true.
	self uniformNodeWidth: true.
	self primarySelectionMode makeDisabledUnselectable: true.
	self focusability: BlFocusability ignore
]

{ #category : #skin }
ToMenuItemListElement >> newRawSkin [ 

	^ ToMenuItemListElementSkin new
]
