Class {
	#name : #ToCircularMenuNodeContainerSkin,
	#superclass : #ToNodeContainerSkin,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> installSkinEventExperimental: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| rotation midAngle element |
			e border: (e valueOfTokenNamed: #'color-border').


			e node background: Color transparent.
			e background: Color white.
			e border: (BlBorderBuilder new
					 paint: Color blue;
					 width: 2;
					 build).
			element := ToMaterialDesignIconProvider iconNamed: 'outlined_add'.
			element extent: 20 asPoint.
			element innerImageColor: Color blue.
			e whenLayoutedDoOnce: [
					rotation := e startAngle + e endAngle / 2.
					midAngle := e startAngle degreesToRadians
					            + e endAngle degreesToRadians / 2.
					rotation := midAngle + Float pi.
					rotation := rotation \\ (2 * Float pi).
					rotation := rotation radiansToDegrees.
					element transformDo: [ :t | t rotateBy: rotation ] ].

			element constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add:
						(c anchors centerAnchor on: (c anchors parent edgePointAnchor
								  offset: 14;
								  outerEdge: false;
								  yourself)) ].

			e addChild: element ]
]

{ #category : #'event handling' }
ToCircularMenuNodeContainerSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
