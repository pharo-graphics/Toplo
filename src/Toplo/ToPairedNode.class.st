Class {
	#name : #ToPairedNode,
	#superclass : #ToPairedElement,
	#traits : 'TToWidgetWithState + TToClickable',
	#classTraits : 'TToWidgetWithState classTrait + TToClickable classTrait',
	#category : #'Toplo-Core-Node'
}

{ #category : #'t - click behavior' }
ToPairedNode >> client [

	^ self holder infiniteElement client
]

{ #category : #'t - initialization dresser' }
ToPairedNode >> defaultDresser [ 

	^ ToPairedNodeDresser new
]
