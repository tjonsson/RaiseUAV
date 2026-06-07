#pragma once

#include "CoreMinimal.h"
#include "Subsystems/WorldSubsystem.h"
#include "RaiseUAVCesiumGeoreferenceSubsystem.generated.h"

UCLASS()
class RAISEUAV_API URaiseUAVCesiumGeoreferenceSubsystem : public UWorldSubsystem
{
    GENERATED_BODY()

public:
    virtual void OnWorldBeginPlay(UWorld& InWorld) override;

protected:
    virtual bool DoesSupportWorldType(const EWorldType::Type WorldType) const override;
};
