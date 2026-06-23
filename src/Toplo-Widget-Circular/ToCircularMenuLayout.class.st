Class {
	#name : #ToCircularMenuLayout,
	#superclass : #ToAnnulusCircularLayout,
	#category : #'Toplo-Widget-Circular-Menu'
}

{ #category : #layout }
ToCircularMenuLayout >> layoutSectors: anElement in: aBounds context: aBlElementBoundsUpdateContext [
	" Align the circular submdenu sectors with the parent menu sector middle angle "

	| sectors sectorsStartAngle sectorsEndAngle sectorsMidAngle parentMenu midAngleGap pmStartAngle pmEndAngle pmSector |
	super
		layoutSectors: anElement
		in: aBounds
		context: aBlElementBoundsUpdateContext.

	parentMenu := anElement listElement menuListOwner.
	(parentMenu notNil and: [ parentMenu isSubmenu ]) ifFalse: [ ^ self ].

	sectors := anElement children accountedByLayout.
	sectors isEmpty ifTrue: [ ^ self ].

	sectorsStartAngle := sectors first startAngleRadians.
	sectorsEndAngle := sectors last endAngleRadians.
	sectorsMidAngle := sectorsEndAngle - sectorsStartAngle / 2.

	sectorsMidAngle < Float pi ifFalse: [ ^ self ].

	pmSector := parentMenu holder nodeContainer.
	pmStartAngle := pmSector startAngleRadians.
	pmEndAngle := pmSector endAngleRadians.
	midAngleGap := sectorsMidAngle - (pmEndAngle - pmStartAngle / 2).

	sectors do: [ :each |
			each
				startAngleRadians: each startAngleRadians - midAngleGap;
				endAngleRadians: each endAngleRadians - midAngleGap ]
]
