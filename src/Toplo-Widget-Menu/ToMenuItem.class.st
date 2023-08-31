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

{ #category : #'t - clickable - click behavior' }
ToMenuItem >> client [

	^ self parentMenu client
]

{ #category : #'t - initialization dresser' }
ToMenuItem >> defaultDresser [ 

	^ ToBasicMenuItemDresser next: (ToButtonMenuItemDresser next: ToTripletDresser new)
]

{ #category : #'t - skinable - initialization' }
ToMenuItem >> defaultSkin [ 

	^ ToMenuItemSkin new
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
	self fitContent
]

{ #category : #'t - orientable - accessing' }
ToMenuItem >> layoutStrategy [

	^ self innerElement layout
]

{ #category : #'t - dressable -  initialization' }
ToMenuItem >> preInitializeDresser [

	super preInitializeDresser.
	self initializeTriplet
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
