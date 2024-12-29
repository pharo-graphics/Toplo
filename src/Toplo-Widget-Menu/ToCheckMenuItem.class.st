Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToToggleMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToCheckMenuItem >> buttonClass [

	^ ToCheckbox
]

{ #category : #initialization }
ToCheckMenuItem >> buttonClickEventClass [ 

	^ ToCheckableCheckEvent 
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checkableData [

	^ self button checkableData
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checkableData: aCheckableData [

	^ self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
ToCheckMenuItem >> indeterminateBar [

	^ self button indeterminateBar
]

{ #category : #skin }
ToCheckMenuItem >> newRawSkin [ 

	^ ToCheckMenuItemSkin new
]
