Class {
	#name : #ToSegmentedNodeDMSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'event handling' }
ToSegmentedNodeDMSkin >> defaultGeometryFor: aSegmentedNode [

	^ BlRectangleGeometry new
]

{ #category : #'event handling' }
ToSegmentedNodeDMSkin >> firstGeometryFor: aSegmentedNode [

	| r |
	r := aSegmentedNode valueOfTokenNamed: #'segmented-border-radius'.
	^ aSegmentedNode isHorizontal
		  ifTrue: [
			  BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
					   topLeft: r;
					   topRight: 0;
					   bottomLeft: r;
					   bottomRight: 0;
					   yourself) ]
		  ifFalse: [
			  BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
					   topLeft: r;
					   topRight: r;
					   bottomLeft: 0;
					   bottomRight: 0;
					   yourself) ]
]

{ #category : #'event handling' }
ToSegmentedNodeDMSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| g |
		e background: BlBackground transparent.
		e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'segmented-node-padding-H')
				 vertical: (e valueOfTokenNamed: #'segmented-node-padding-V')).
		g := e isFirst
			     ifTrue: [ self firstGeometryFor: e ]
			     ifFalse: [
				     e isLast
					     ifTrue: [ self lastGeometryFor: e ]
					     ifFalse: [ self defaultGeometryFor: e ] ].
		e geometry: g.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')).
		e outskirts: BlOutskirts outside ]
]

{ #category : #'event handling' }
ToSegmentedNodeDMSkin >> lastGeometryFor: aSegmentedNode [

	| r |
	r := aSegmentedNode valueOfTokenNamed: #'segmented-border-radius'.
	^ aSegmentedNode isHorizontal
		  ifTrue: [
			  BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
					   topLeft: 0;
					   topRight: r;
					   bottomLeft: 0;
					   bottomRight: r;
					   yourself) ]
		  ifFalse: [
			  BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
					   topLeft: 0;
					   topRight: 0;
					   bottomLeft: r;
					   bottomRight: r;
					   yourself) ]
]
