"
I'm list whose contents is a segmented element (i.e. a list of toggle elements)
"
Class {
	#name : #ToSegmentedBarElement,
	#superclass : #ToCheckableBarElement,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #skin }
ToSegmentedBarElement >> newRawSkin [ 

	^ ToSegmentedBarElementSkin new
]
