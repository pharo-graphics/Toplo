Class {
	#name : #ToTooltipWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #skin }
ToTooltipWindow >> newRawSkin [

	^ ToTooltipWindowSkin new
]
