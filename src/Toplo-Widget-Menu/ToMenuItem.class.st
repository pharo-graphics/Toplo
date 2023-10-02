Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickable + TToLabeledIcon + TToTriplet + TToOrientable',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickable classTrait + TToLabeledIcon classTrait + TToTriplet classTrait + TToOrientable classTrait',
	#instVars : [
		'#icon => ToSkinnableSlot',
		'#label => ToSkinnableSlot',
		'#extra => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - clickable - click behavior' }
ToMenuItem >> clickEventClass [

	^ BlMouseUpEvent
]

{ #category : #'as yet unclassified' }
ToMenuItem >> client [

	^ self parentMenu client
]

{ #category : #initialization }
ToMenuItem >> defaultEventHandler [ 

	^ ToMenuItemEventHandler new
]

{ #category : #'t - triplet - accessing' }
ToMenuItem >> first [

	^ icon
]

{ #category : #'t - triplet - accessing' }
ToMenuItem >> first: anElement [

	icon := anElement
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self initializeTriplet
]

{ #category : #'t - orientable - accessing' }
ToMenuItem >> layoutStrategy [

	^ self innerElement layout
]

{ #category : #'t - triplet - accessing' }
ToMenuItem >> second [

	^ label
]

{ #category : #'t - triplet - accessing' }
ToMenuItem >> second: anElement [

	label := anElement
]

{ #category : #'t - triplet - accessing' }
ToMenuItem >> third [

	^ extra
]

{ #category : #'t - triplet - accessing' }
ToMenuItem >> third: anElement [

	extra := anElement

]
