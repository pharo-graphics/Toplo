Class {
	#name : #ToCornerResizeHandle,
	#superclass : #ToPredefinedResizeHandle,
	#category : #'Toplo-Layout-Support-Handles'
}

{ #category : #configuration }
ToCornerResizeHandle >> applyConfiguration [

	super applyConfiguration.
	self extent: (thickness * 2) asPoint.

]
