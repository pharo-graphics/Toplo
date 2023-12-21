Class {
	#name : 'ToSelectNode',
	#superclass : 'ToNode',
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'initialization' }
ToSelectNode >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self padding: (BlInsets horizontal: 6 vertical: 4).
	self margin: (BlInsets all: 2).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	self background: (Color lightGray alpha: 0.3).
	self fitContent
]
